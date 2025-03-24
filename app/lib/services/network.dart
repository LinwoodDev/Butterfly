import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:cryptography_plus/cryptography_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swamp_api/connection.dart';

part 'network.freezed.dart';
part 'network.g.dart';

enum NetworkingType {
  webSocket;

  Future<bool> isCompatible() async => switch (this) {
        NetworkingType.webSocket => !kIsWeb,
      };
}

const kDefaultPort = 28005;
const kBroadcastPort = kDefaultPort + 1;
const kTimeout = Duration(minutes: 5);

sealed class NetworkState {
  NetworkerBase get connection;
  final NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> pipe;

  NetworkState({
    required this.pipe,
  });

  FutureOr<String> getShareAddress() {
    return connection.address.toString();
  }
}

final class ServerNetworkState extends NetworkState {
  @override
  final NetworkerServerMixin connection;
  final bool queue;
  final String password;

  ServerNetworkState({
    required super.pipe,
    required this.connection,
    this.queue = true,
    this.password = '',
  });

  @override
  Future<String> getShareAddress() async {
    if (connection is SwampConnection) {
      return (await (connection as SwampConnection).getSecureAddress())
          .toString();
    }
    return super.getShareAddress();
  }
}

final class ClientNetworkState extends NetworkState {
  @override
  final NetworkerClientMixin connection;

  ClientNetworkState({required super.pipe, required this.connection});
}

@freezed
sealed class NetworkingUser with _$NetworkingUser {
  const factory NetworkingUser({
    @DoublePointJsonConverter() Point<double>? cursor,
    List<PadElement>? foreground,
  }) = _NetworkingUser;

  factory NetworkingUser.fromJson(Map<String, dynamic> json) =>
      _$NetworkingUserFromJson(json);
}

enum NetworkEvent with RpcFunctionName {
  event(mode: RpcNetworkerMode.any, canRunLocally: false),
  init(mode: RpcNetworkerMode.authority, canRunLocally: false),
  connections(mode: RpcNetworkerMode.authority, canRunLocally: false),
  user(mode: RpcNetworkerMode.any, canRunLocally: false);

  @override
  final RpcNetworkerMode mode;
  @override
  final bool canRunLocally;

  const NetworkEvent(
      {this.mode = RpcNetworkerMode.authority, this.canRunLocally = false});
}

enum ConnectionTechnology {
  webSocket,
  swamp,
}

class NetworkingService extends Cubit<NetworkState?> {
  DocumentBloc? _bloc;
  final BehaviorSubject<Set<Channel>> _connections = BehaviorSubject.seeded({});
  final BehaviorSubject<Map<Channel?, NetworkingUser>> _users =
      BehaviorSubject.seeded({});

  Stream<Set<Channel>> get connectionsStream => _connections.stream;
  Set<Channel> get connections => _connections.value;

  Stream<Map<Channel?, NetworkingUser>> get usersStream => _users.stream;
  Map<Channel?, NetworkingUser> get users => _users.value;

  NetworkingService() : super(null);

  bool get isActive => state != null;

  void setup(DocumentBloc bloc) {
    _bloc = bloc;
  }

  Future<void> createSocketServer([String? address, int? port]) async {
    closeNetworking();
    final server = NetworkerSocketServer(
        address != null
            ? InternetAddress(address, type: InternetAddressType.any)
            : InternetAddress.anyIPv4,
        port ?? kDefaultPort);
    final rpc = NamedRpcServerNetworkerPipe<NetworkEvent, NetworkEvent>();
    _setupServer(rpc, server);
    server.connect(rpc);
    await server.init();
    emit(ServerNetworkState(connection: server, pipe: rpc));
  }

  Future<Uint8List?> createSocketClient(Uri uri) async {
    closeNetworking();
    if (!uri.hasPort) {
      uri = uri.replace(port: kDefaultPort);
    }
    if (!uri.hasScheme) {
      uri = uri.replace(scheme: 'ws');
    }
    final client = NetworkerSocketClient(uri);
    final rpc = NamedRpcClientNetworkerPipe<NetworkEvent, NetworkEvent>();
    final data = _setupClient(rpc, client);
    client.connect(rpc);
    await client.init();
    emit(ClientNetworkState(connection: client, pipe: rpc));
    return data;
  }

  void closeNetworking() {
    state?.connection.close();
    emit(null);
    _connections.add({});
    _users.add({});
  }

  Future<Uint8List?> _setupClient(
      NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc,
      NetworkerClientMixin client) async {
    _setupRpc(rpc, client);
    final completer = Completer<Uint8List?>();
    rpc.registerNamedFunction(NetworkEvent.init).read.listen((message) {
      completer.complete(message.data);
    });
    return completer.future.timeout(kTimeout);
  }

  void _setupServer(NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc,
      NetworkerServerMixin server) {
    void sendConnections() {
      final current = server.clientConnections;
      _connections.add(current);
      rpc.sendNamedFunction(
        NetworkEvent.connections,
        Uint8List.fromList(jsonEncode(current.toList()).codeUnits),
      );
    }

    server.clientConnect.listen((event) async {
      final state = _bloc?.state;
      if (state is! DocumentLoaded) return;
      rpc.sendNamedFunction(NetworkEvent.init, await state.saveBytes(),
          channel: event.$1);
      sendConnections();
    });
    server.clientDisconnect.listen((event) {
      sendConnections();
    });
  }

  void _setupRpc(NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc,
      NetworkerBase networker) {
    rpc.registerNamedFunctions(NetworkEvent.values);
    rpc.getNamedFunction(NetworkEvent.event)?.connect(RawJsonNetworkerPlugin()
      ..read.listen((message) {
        final event = DocumentEvent.fromJson(message.data);
        onMessage(event);
      }));
    rpc
        .getNamedFunction(NetworkEvent.connections)
        ?.connect(RawJsonNetworkerPlugin()
          ..read.listen((message) {
            final ids = Set<Channel>.from(message.data);
            _connections.add(ids);
            _users.add(Map.from(_users.value)
              ..removeWhere((key, value) => !ids.contains(key)));
          }));
    rpc.getNamedFunction(NetworkEvent.user)?.connect(RawJsonNetworkerPlugin()
      ..read.listen((message) {
        final user = NetworkingUser.fromJson(message.data);
        final users = Map<Channel?, NetworkingUser>.from(_users.value)
          ..[message.channel] = user;
        _users.add(users);
        _bloc?.state.currentIndexCubit?.updateNetworkingState(_bloc!, users);
      }));
  }

  void sendUser(NetworkingUser user) {
    state?.pipe.sendNamedFunction(NetworkEvent.user,
        Uint8List.fromList(jsonEncode(user.toJson()).codeUnits));
  }

  bool _externalEvent = false;

  bool get isClient => state is ClientNetworkState;
  bool get isServer => state is ServerNetworkState;

  void onEvent(DocumentEvent event) {
    if (!event.shouldSync() || _externalEvent) return;
    state?.pipe.sendNamedFunction(
      NetworkEvent.event,
      Uint8List.fromList(
        jsonEncode(event.toJson()).codeUnits,
      ),
    );
  }

  void onMessage(DocumentEvent event) {
    if (!event.shouldSync()) return;
    _externalEvent = true;
    _bloc?.add(event);
    _externalEvent = false;
  }

  Cipher _buildCipher() => AesGcm.with256bits();

  Future<SwampConnection> _createSwamp(Uri uri) {
    if (uri.scheme.isEmpty) {
      uri = uri.replace(scheme: 'wss');
    }
    final cipher = _buildCipher();
    return SwampConnection.buildSecure(uri, cipher);
  }

  Future<Uint8List?> createSwampClient(Uri uri) async {
    closeNetworking();
    final connection = await _createSwamp(uri);
    final rpc = NamedRpcClientNetworkerPipe<NetworkEvent, NetworkEvent>(
        config: RpcConfig(channelField: false));
    final data = _setupClient(rpc, connection);
    connection.messagePipe.connect(rpc);
    await Future.wait([
      connection.init(),
      connection.onRoomInfo.first,
    ]).timeout(kTimeout);
    emit(ClientNetworkState(connection: connection, pipe: rpc));
    return data;
  }

  Future<void> createSwampServer(Uri uri) async {
    closeNetworking();
    final connection = await _createSwamp(uri);
    final rpc = NamedRpcClientNetworkerPipe<NetworkEvent, NetworkEvent>(
        config: RpcConfig(channelField: false));
    _setupServer(rpc, connection);
    _setupRpc(rpc, connection);
    connection.messagePipe.connect(rpc);
    await Future.wait([
      connection.init(),
      connection.onRoomInfo.first,
    ]).timeout(kTimeout);
    emit(ServerNetworkState(connection: connection, pipe: rpc));
  }

  Future<Uint8List?> createClient(Uri uri,
          [ConnectionTechnology technology = ConnectionTechnology.swamp]) =>
      switch (technology) {
        ConnectionTechnology.webSocket => createSocketClient(uri),
        ConnectionTechnology.swamp => createSwampClient(uri)
      };
}
