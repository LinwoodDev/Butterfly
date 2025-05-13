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
import 'package:network_info_plus/network_info_plus.dart';

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

  Future<Uri> getShareAddress() async {
    if (connection is SwampConnection) {
      return await (connection as SwampConnection).getSecureAddress();
    }
    if (connection is NetworkerSocketServer) {
      final ip = await NetworkInfo().getWifiIP();
      return Uri(
        scheme: 'ws',
        host: ip ?? 'localhost',
        port: (connection as NetworkerSocketServer).port,
      );
    }
    return connection.address;
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
}

final class DisconnectedNetworkState extends NetworkState {
  @override
  final NetworkerClientMixin connection;

  DisconnectedNetworkState({
    required super.pipe,
    required this.connection,
  });
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
    @Default('') String name,
  }) = _NetworkingUser;

  factory NetworkingUser.fromJson(Map<String, dynamic> json) =>
      _$NetworkingUserFromJson(json);
}

enum NetworkEvent with RpcFunctionName {
  event(mode: RpcNetworkerMode.any, canRunLocally: false),
  init(mode: RpcNetworkerMode.authority, canRunLocally: false),
  connections(mode: RpcNetworkerMode.authority, canRunLocally: false),
  user(mode: RpcNetworkerMode.any, canRunLocally: false),
  undo(mode: RpcNetworkerMode.any, canRunLocally: false),
  redo(mode: RpcNetworkerMode.any, canRunLocally: false);

  @override
  final RpcNetworkerMode mode;
  @override
  final bool canRunLocally;

  const NetworkEvent(
      {this.mode = RpcNetworkerMode.authority, this.canRunLocally = false});
}

enum ConnectionTechnology {
  swamp,
  webSocket;

  static ConnectionTechnology fromScheme(String scheme) => switch (scheme) {
        'ws' || 'wss' => ConnectionTechnology.webSocket,
        _ => ConnectionTechnology.swamp,
      };
}

class NetworkingService extends Cubit<NetworkState?> {
  DocumentBloc? _bloc;
  String _userName = '';
  final BehaviorSubject<Set<Channel>> _connections = BehaviorSubject.seeded({});
  final BehaviorSubject<Map<Channel, NetworkingUser>> _users =
      BehaviorSubject.seeded({});

  String get userName => _userName;

  Stream<Set<Channel>> get connectionsStream => _connections.stream;
  Set<Channel> get connections => _connections.value;

  Stream<Map<Channel?, NetworkingUser>> get usersStream => _users.stream;
  Map<Channel, NetworkingUser> get users => _users.value;

  final StreamController<Uint8List> _resetController =
      StreamController.broadcast();

  Stream<Uint8List> get resetStream => _resetController.stream;

  NetworkingService() : super(null);

  bool get isActive => state != null;

  void setup(DocumentBloc bloc) {
    _bloc = bloc;
    resetStream.listen((event) {
      bloc.add(DocumentRebuilt(event));
    });
  }

  Future<void> createSocketServer([String? address, int? port]) async {
    await closeNetworking();
    final server = NetworkerSocketServer(
        address != null
            ? InternetAddress(address, type: InternetAddressType.any)
            : InternetAddress.anyIPv4,
        port ?? kDefaultPort);
    final rpc = NamedRpcServerNetworkerPipe<NetworkEvent, NetworkEvent>();
    _setupServer(rpc, server);
    _setupRpc(rpc, server);
    server.connect(rpc);
    await server.init();
    emit(ServerNetworkState(connection: server, pipe: rpc));
  }

  Future<Uint8List?> createSocketClient(Uri uri) async {
    await closeNetworking();
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

  Future<void> closeNetworking() async {
    await state?.connection.close();
    emit(null);
    _connections.add({});
    _users.add({});
  }

  void _setupReset(NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc) {
    rpc.registerNamedFunction(NetworkEvent.init).read.listen((message) {
      _resetController.add(message.data);
    });
  }

  Future<Uint8List?> _setupClient(
      NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc,
      NetworkerClientMixin client) async {
    _setupRpc(rpc, client);
    client.onClosed.listen((event) {
      emit(DisconnectedNetworkState(connection: client, pipe: rpc));
    });
    final completer = Completer<Uint8List?>();
    final listener =
        rpc.registerNamedFunction(NetworkEvent.init).read.listen((message) {
      completer.complete(message.data);
    });
    return completer.future.timeout(kTimeout).then((e) {
      listener.cancel();
      _setupReset(rpc);
      return e;
    }).catchError((_) {
      emit(DisconnectedNetworkState(connection: client, pipe: rpc));
      return null;
    });
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
      for (final user in users.entries) {
        rpc.sendNamedFunction(
          NetworkEvent.user,
          Uint8List.fromList(jsonEncode(user.value.toJson()).codeUnits),
          channel: event.$1,
        );
      }
    });
    server.clientDisconnect.listen((event) {
      sendConnections();
    });
  }

  Future<void> sendInit(
      {Channel channel = kAnyChannel, DocumentState? docState}) async {
    final blocState = docState ?? _bloc?.state;
    if (blocState is! DocumentLoaded) return;
    final state = this.state;
    if (state == null) return;
    state.pipe.sendNamedFunction(NetworkEvent.init, await blocState.saveBytes(),
        channel: channel);
  }

  void _setupRpc(NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc,
      NetworkerBase networker) {
    _userName = '';

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
        final users = Map<Channel, NetworkingUser>.from(_users.value)
          ..[message.channel] = user;
        _users.add(users);
        _bloc?.state.currentIndexCubit?.updateNetworkingState(_bloc!, users);
      }));
    rpc.getNamedFunction(NetworkEvent.undo)?.read.listen((_) {
      _bloc?.undo();
      _needsInit = true;
      _bloc
          ?.load()
          .then((value) => _bloc?.bake().then((value) => _bloc?.save()));
    });
    rpc.getNamedFunction(NetworkEvent.redo)?.read.listen((_) {
      _bloc?.redo();
      _needsInit = true;
      _bloc
          ?.load()
          .then((value) => _bloc?.bake().then((value) => _bloc?.save()));
    });
  }

  bool _needsInit = false;

  bool sendUndo() {
    final state = this.state;
    if (state == null) return false;
    if (state is ClientNetworkState) {
      state.pipe.sendNamedFunction(NetworkEvent.undo, Uint8List(0));
      return true;
    }
    _bloc?.undo();
    _needsInit = true;
    return true;
  }

  bool sendRedo() {
    final state = this.state;
    if (state == null) return false;
    if (state is ClientNetworkState) {
      state.pipe.sendNamedFunction(NetworkEvent.redo, Uint8List(0));
      return true;
    }
    _bloc?.redo();
    _needsInit = true;
    return true;
  }

  void sendUser(NetworkingUser user) {
    state?.pipe.sendNamedFunction(NetworkEvent.user,
        Uint8List.fromList(jsonEncode(user.toJson()).codeUnits));
  }

  bool _externalEvent = false;

  bool get isClient => state is ClientNetworkState;
  bool get isServer => state is ServerNetworkState;

  void testForInits(DocumentState state) {
    if (!_needsInit) return;
    _needsInit = false;
    sendInit(docState: state);
  }

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
    await closeNetworking();
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
    await closeNetworking();
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
          [ConnectionTechnology? technology]) =>
      switch (technology ?? ConnectionTechnology.fromScheme(uri.scheme)) {
        ConnectionTechnology.webSocket => createSocketClient(uri),
        ConnectionTechnology.swamp => createSwampClient(uri)
      };

  NetworkingUser getUser(Channel channel) =>
      users[channel] ?? const NetworkingUser();

  void setName(String name) {
    _userName = name;
    sendUser(NetworkingUser(name: name));
  }
}
