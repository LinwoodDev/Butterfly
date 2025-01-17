import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:rxdart/rxdart.dart';

part 'network.freezed.dart';
part 'network.g.dart';

enum NetworkingType {
  webSocket;

  Future<bool> isCompatible() async => switch (this) {
        NetworkingType.webSocket => !kIsWeb,
      };
}

const kDefaultPort = 28005;
const kTimeout = Duration(minutes: 5);
typedef NetworkingState = (NetworkerBase, NamedRpcNetworkerPipe<NetworkEvent>);

@freezed
class NetworkingUser with _$NetworkingUser {
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

class NetworkingService {
  DocumentBloc? _bloc;
  final BehaviorSubject<NetworkingState?> _subject =
      BehaviorSubject.seeded(null);
  final BehaviorSubject<Set<Channel>> _connections = BehaviorSubject.seeded({});
  final BehaviorSubject<Map<Channel?, NetworkingUser>> _users =
      BehaviorSubject.seeded({});

  Stream<NetworkingState?> get stream => _subject.stream;
  NetworkingState? get state => _subject.value;

  Stream<Set<Channel>> get connectionsStream => _connections.stream;
  Set<Channel> get connections => _connections.value;

  Stream<Map<Channel?, NetworkingUser>> get usersStream => _users.stream;
  Map<Channel?, NetworkingUser> get users => _users.value;

  NetworkingService();

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
    final rpc = NamedRpcServerNetworkerPipe<NetworkEvent>();
    _setupRpc(rpc, server);
    void sendConnections() {
      final current = server.clientConnections;
      _connections.add(current);
      rpc.sendMessage(RpcNetworkerPacket(
        function: NetworkEvent.connections.index,
        data: Uint8List.fromList(jsonEncode(current.toList()).codeUnits),
        channel: kAuthorityChannel,
      ));
    }

    server.clientConnect.listen((event) async {
      final state = _bloc?.state;
      if (state is! DocumentLoaded) return;
      rpc.sendMessage(
          RpcNetworkerPacket(
            function: NetworkEvent.init.index,
            data: await state.saveBytes(),
            channel: kAuthorityChannel,
          ),
          event.$1);
      sendConnections();
    });
    server.clientDisconnect.listen((event) {
      sendConnections();
    });
    server.connect(rpc);
    await server.init();
    _subject.add((server, rpc));
  }

  Future<Uint8List?> createSocketClient(Uri uri) async {
    closeNetworking();
    if (!uri.hasPort) {
      uri = uri.replace(port: kDefaultPort);
    }
    if(!uri.hasScheme) {
      uri = uri.replace(scheme: 'ws');
    }
    final client = NetworkerSocketClient(uri);
    final rpc = NamedRpcClientNetworkerPipe<NetworkEvent>();
    _setupRpc(rpc, client);
    final completer = Completer<Uint8List?>();
    rpc.registerNamedFunction(NetworkEvent.init).read.listen((message) {
      completer.complete(message.data);
    });
    client.connect(rpc);
    await client.init();
    _subject.add((client, rpc));
    return completer.future.timeout(kTimeout);
  }

  void closeNetworking() {
    state?.$1.close();
    _subject.add(null);
    _connections.add({});
    _users.add({});
  }

  void _setupRpc(
      NamedRpcNetworkerPipe<NetworkEvent> rpc, NetworkerBase networker) {
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
    state?.$2.sendMessage(RpcNetworkerPacket(
      function: NetworkEvent.user.index,
      data: Uint8List.fromList(jsonEncode(user.toJson()).codeUnits),
      channel: kAuthorityChannel,
    ));
  }

  bool _externalEvent = false;

  void onEvent(DocumentEvent event) {
    if (!event.shouldSync() || _externalEvent) return;
    state?.$2.sendMessage(RpcNetworkerPacket(
      function: NetworkEvent.event.index,
      data: Uint8List.fromList(
        jsonEncode(event.toJson()).codeUnits,
      ),
      channel: state?.$1 is NetworkerServer ? kAuthorityChannel : kAnyChannel,
    ));
  }

  void onMessage(DocumentEvent event) {
    if (!event.shouldSync()) return;
    _externalEvent = true;
    _bloc?.add(event);
    _externalEvent = false;
  }
}
