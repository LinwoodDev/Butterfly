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

const kDefaultPort = 28005;
const kBroadcastPort = kDefaultPort + 1;
const kTimeout = Duration(seconds: 30);

sealed class NetworkState {
  NetworkerBase get connection;
  final NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> pipe;

  NetworkState({required this.pipe});

  Future<Uri> getShareAddress() async {
    if (connection is SwampConnection) {
      return await (connection as SwampConnection).getSecureAddress();
    }
    if (connection is NetworkerSocketServer) {
      final ip = await NetworkInfo().getWifiIP();
      return Uri(
        scheme: 'ws',
        host: ip ?? 'localhost',
        port: connection.address.port,
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

  DisconnectedNetworkState({required super.pipe, required this.connection});
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

  const NetworkEvent({
    this.mode = RpcNetworkerMode.authority,
    this.canRunLocally = false,
  });
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
  final Duration timeout;
  DocumentBloc? _bloc;
  StreamSubscription<Uint8List>? _resetSubscription;
  StreamSubscription<void>? _clientClosedSubscription;
  String _userName = '';
  final BehaviorSubject<Set<Channel>> _connections = BehaviorSubject.seeded({});
  final BehaviorSubject<Map<Channel, NetworkingUser>> _users =
      BehaviorSubject.seeded({});

  String get userName => _userName;

  Stream<Set<Channel>> get connectionsStream => _connections.stream;
  Set<Channel> get connections => _connections.value;

  Stream<Map<Channel, NetworkingUser>> get usersStream => _users.stream;
  Map<Channel, NetworkingUser> get users => _users.value;

  final StreamController<Uint8List> _resetController =
      StreamController.broadcast();

  Stream<Uint8List> get resetStream => _resetController.stream;

  NetworkingService({this.timeout = kTimeout}) : super(null);

  bool get isActive =>
      state is ServerNetworkState || state is ClientNetworkState;

  bool get _canEmitConnections => !_connections.isClosed;

  bool get _canEmitUsers => !_users.isClosed;

  void _emitConnections(Set<Channel> value) {
    if (_canEmitConnections) {
      _connections.add(value);
    }
  }

  void _emitUsers(Map<Channel, NetworkingUser> value) {
    if (_canEmitUsers) {
      _users.add(value);
    }
    final bloc = _bloc;
    if (bloc != null) {
      bloc.editorController.updateNetworkingState(bloc, value);
    }
  }

  void _setConnections(Set<Channel> value) {
    _emitConnections(value);
    _emitUsers(
      Map<Channel, NetworkingUser>.from(_users.value)
        ..removeWhere((channel, _) => !value.contains(channel)),
    );
  }

  void setup(DocumentBloc bloc) {
    _bloc = bloc;
    _resetSubscription?.cancel();
    _resetSubscription = resetStream.listen((event) {
      bloc.add(DocumentRebuilt(event));
    });
    setName(bloc.editorController.viewCubit.state.userName);
  }

  Future<void> createSocketServer([String? address, int? port]) async {
    await closeNetworking();
    final server = NetworkerSocketServer(
      address != null
          ? InternetAddress(address, type: InternetAddressType.any)
          : InternetAddress.anyIPv4,
      port ?? kDefaultPort,
    );
    final rpc = NamedRpcServerNetworkerPipe<NetworkEvent, NetworkEvent>();
    _setupServer(rpc, server);
    _setupRpc(rpc, server);
    server.connect(rpc);
    try {
      await server.init().timeout(timeout);
      emit(ServerNetworkState(connection: server, pipe: rpc));
    } catch (_) {
      await server.close();
      rethrow;
    }
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
    client.connect(rpc);
    return _initializeClient(rpc, client, client.init);
  }

  Future<void> closeNetworking() async {
    final connection = state?.connection;
    emit(null);
    await _clientClosedSubscription?.cancel();
    _clientClosedSubscription = null;
    try {
      await connection?.close();
    } finally {
      _setConnections({});
    }
  }

  void _setupReset(NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc) {
    rpc.registerNamedFunction(NetworkEvent.init).read.listen((message) {
      _resetController.add(message.data);
    });
  }

  Future<Uint8List?> _initializeClient(
    NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc,
    NetworkerClientMixin client,
    Future<void> Function() initialize,
  ) async {
    _setupRpc(rpc, client);
    final initialData = Completer<Uint8List?>();
    final disconnected = Completer<Never>();
    void disconnect([Object? error, StackTrace? stackTrace]) {
      if (!disconnected.isCompleted) {
        disconnected.completeError(
          error ?? StateError('The collaboration connection was closed.'),
          stackTrace,
        );
      }
      if (identical(state?.connection, client)) {
        emit(DisconnectedNetworkState(connection: client, pipe: rpc));
        _setConnections({});
      }
    }

    await _clientClosedSubscription?.cancel();
    _clientClosedSubscription = client.onClosed.listen(
      (_) => disconnect(),
      onError: (Object error, StackTrace stackTrace) =>
          disconnect(error, stackTrace),
    );
    final listener = rpc.registerNamedFunction(NetworkEvent.init).read.listen((
      message,
    ) {
      if (!initialData.isCompleted) {
        initialData.complete(message.data);
      }
    });
    try {
      await Future.any<void>([
        initialize().timeout(timeout),
        disconnected.future,
      ]);
      emit(ClientNetworkState(connection: client, pipe: rpc));
      final data = await Future.any<Uint8List?>([
        initialData.future,
        disconnected.future,
      ]).timeout(timeout);
      _setupReset(rpc);
      return data;
    } catch (_) {
      if (identical(state?.connection, client)) {
        emit(null);
      }
      await _clientClosedSubscription?.cancel();
      _clientClosedSubscription = null;
      await client.close();
      rethrow;
    } finally {
      await listener.cancel();
    }
  }

  void _setupServer(
    NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc,
    NetworkerServerMixin server,
  ) {
    void sendConnections() {
      final current = server.clientConnections;
      _setConnections(current);
      final sharedConnections = {kAuthorityChannel, ...current};
      rpc.sendNamedFunction(
        NetworkEvent.connections,
        Uint8List.fromList(jsonEncode(sharedConnections.toList()).codeUnits),
      );
    }

    server.clientConnect.listen((event) async {
      final state = _bloc?.state;
      if (state is! DocumentLoaded) {
        await server.closeConnection(event.$1);
        return;
      }
      try {
        rpc.sendNamedFunction(
          NetworkEvent.init,
          await state.saveBytes(),
          channel: event.$1,
        );
        sendConnections();
        rpc.sendNamedFunction(
          NetworkEvent.user,
          Uint8List.fromList(
            jsonEncode(NetworkingUser(name: _userName).toJson()).codeUnits,
          ),
          channel: event.$1,
        );
        for (final user in users.entries) {
          rpc.sendNamedFunction(
            NetworkEvent.user,
            Uint8List.fromList(jsonEncode(user.value.toJson()).codeUnits),
            channel: event.$1,
            receiver: user.key,
          );
        }
      } catch (_) {
        await server.closeConnection(event.$1);
      }
    });
    server.clientDisconnect.listen((event) {
      sendConnections();
    });
  }

  Future<void> sendInit({
    Channel channel = kAnyChannel,
    DocumentState? docState,
  }) async {
    final blocState = docState ?? _bloc?.state;
    if (blocState is! DocumentLoaded) return;
    final state = this.state;
    if (state == null || state is DisconnectedNetworkState) return;
    state.pipe.sendNamedFunction(
      NetworkEvent.init,
      await blocState.saveBytes(),
      channel: channel,
    );
  }

  void _setupRpc(
    NamedRpcNetworkerPipe<NetworkEvent, NetworkEvent> rpc,
    NetworkerBase networker,
  ) {
    rpc.registerNamedFunctions(NetworkEvent.values);
    rpc
        .getNamedFunction(NetworkEvent.event)
        ?.connect(
          RawJsonNetworkerPlugin()
            ..read.listen((message) {
              final event = DocumentEvent.fromJson(message.data);
              onMessage(event);
            }),
        );
    rpc
        .getNamedFunction(NetworkEvent.connections)
        ?.connect(
          RawJsonNetworkerPlugin()
            ..read.listen((message) {
              final ids = Set<Channel>.from(message.data);
              _setConnections(ids);
            }),
        );
    rpc
        .getNamedFunction(NetworkEvent.user)
        ?.connect(
          RawJsonNetworkerPlugin()
            ..read.listen((message) {
              final user = NetworkingUser.fromJson(message.data);
              final users = Map<Channel, NetworkingUser>.from(_users.value)
                ..[message.channel] = user;
              _emitUsers(users);
            }),
        );
    rpc.getNamedFunction(NetworkEvent.undo)?.read.listen((_) {
      _bloc?.undo();
      _needsInit = true;
      _bloc?.reload();
    });
    rpc.getNamedFunction(NetworkEvent.redo)?.read.listen((_) {
      _bloc?.redo();
      _needsInit = true;
      _bloc?.reload();
    });
  }

  bool _needsInit = false;

  bool sendUndo() {
    final state = this.state;
    if (state == null || state is DisconnectedNetworkState) return false;
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
    if (state == null || state is DisconnectedNetworkState) return false;
    if (state is ClientNetworkState) {
      state.pipe.sendNamedFunction(NetworkEvent.redo, Uint8List(0));
      return true;
    }
    _bloc?.redo();
    _needsInit = true;
    return true;
  }

  void sendUser(NetworkingUser user) {
    final state = this.state;
    if (state == null || state is DisconnectedNetworkState) return;
    state.pipe.sendNamedFunction(
      NetworkEvent.user,
      Uint8List.fromList(jsonEncode(user.toJson()).codeUnits),
    );
  }

  bool _externalEvent = false;

  bool get isClient =>
      state is ClientNetworkState || state is DisconnectedNetworkState;
  bool get isServer => state is ServerNetworkState;

  void testForInits(DocumentState state) {
    if (!_needsInit || !isActive) return;
    _needsInit = false;
    sendInit(docState: state);
  }

  void onEvent(DocumentEvent event) {
    if (!event.shouldSync() || _externalEvent || !isActive) return;
    state?.pipe.sendNamedFunction(
      NetworkEvent.event,
      Uint8List.fromList(jsonEncode(event.toJson()).codeUnits),
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
    if (!uri.hasAuthority) {
      uri = Uri.parse('wss://${uri.toString()}');
    }
    final cipher = _buildCipher();
    return SwampConnection.buildSecure(uri, cipher);
  }

  Future<Uint8List?> createSwampClient(Uri uri) async {
    await closeNetworking();
    final connection = await _createSwamp(uri);
    final rpc = NamedRpcClientNetworkerPipe<NetworkEvent, NetworkEvent>(
      config: RpcConfig(channelField: false),
    );
    connection.messagePipe.connect(rpc);
    return _initializeClient(rpc, connection, () async {
      await Future.wait([connection.init(), connection.onRoomInfo.first]);
    });
  }

  Future<void> createSwampServer(Uri uri) async {
    await closeNetworking();
    final connection = await _createSwamp(uri);
    final rpc = NamedRpcClientNetworkerPipe<NetworkEvent, NetworkEvent>(
      config: RpcConfig(channelField: false),
    );
    _setupServer(rpc, connection);
    _setupRpc(rpc, connection);
    connection.messagePipe.connect(rpc);
    try {
      await Future.wait([connection.init(), connection.onRoomInfo.first])
          .timeout(timeout);
      emit(ServerNetworkState(connection: connection, pipe: rpc));
    } catch (_) {
      await connection.close();
      rethrow;
    }
  }

  Future<Uint8List?> createClient(
    Uri uri, [
    ConnectionTechnology? technology,
  ]) => switch (technology ?? ConnectionTechnology.fromScheme(uri.scheme)) {
    ConnectionTechnology.webSocket => createSocketClient(uri),
    ConnectionTechnology.swamp => createSwampClient(uri),
  };

  NetworkingUser getUser(Channel channel) =>
      users[channel] ?? const NetworkingUser();

  void setName(String name) {
    _userName = name;
    sendUser(NetworkingUser(name: name));
  }

  @override
  Future<void> close() async {
    _bloc = null;
    _resetSubscription?.cancel();
    _resetSubscription = null;
    await _clientClosedSubscription?.cancel();
    _clientClosedSubscription = null;
    await closeNetworking();
    await _connections.close();
    await _users.close();
    await _resetController.close();
    return super.close();
  }
}
