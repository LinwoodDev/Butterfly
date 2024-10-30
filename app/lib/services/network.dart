import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:rxdart/rxdart.dart';

part 'network.freezed.dart';
part 'network.g.dart';

enum NetworkingSide {
  server,
  client,
}

enum NetworkingType {
  webSocket,
  webRtc;

  Future<bool> isCompatible() async => switch (this) {
        NetworkingType.webRtc => kIsWeb ||
            !Platform.isAndroid ||
            (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 28,
        NetworkingType.webSocket => !kIsWeb,
      };
}

const kDefaultPort = 28005;
const kTimeout = Duration(seconds: 10);
typedef NetworkingState = (NetworkerBase, NamedRpcNetworkerPipe<NetworkEvent>);

@freezed
class NetworkingInitMessage with _$NetworkingInitMessage {
  const factory NetworkingInitMessage(List<int>? data) = _NetworkingInitMessage;

  factory NetworkingInitMessage.fromJson(Map<String, dynamic> json) =>
      _$NetworkingInitMessageFromJson(json);
}

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
      rpc.callFunction(NetworkEvent.connections.index,
          Uint8List.fromList(jsonEncode(connections.toList()).codeUnits));
    }

    server.clientConnect.listen((event) async {
      final state = _bloc?.state;
      rpc.callFunction(
          NetworkEvent.init.index,
          Uint8List.fromList(
              jsonEncode(NetworkingInitMessage((await state?.saveBytes())))
                  .codeUnits));
      sendConnections();
    });
    server.clientDisconnect.listen((event) {
      sendConnections();
    });
    server.connect(rpc);
    _subject.add((server, rpc));
  }

  Future<Uint8List?> createSocketClient(Uri uri) async {
    closeNetworking();
    if (!uri.hasPort) {
      uri = uri.replace(port: kDefaultPort);
    }
    final client = NetworkerSocketClient(uri);
    final rpc = NamedRpcClientNetworkerPipe<NetworkEvent>();
    _setupRpc(rpc, client);
    final completer = Completer<Uint8List?>();
    rpc
        .registerFunction(NetworkEvent.init.index,
            mode: RpcNetworkerMode.authority)
        .connect(RawJsonNetworkerPlugin()
          ..read.listen((message) {
            final init = NetworkingInitMessage.fromJson(message.data);
            completer.complete(
                init.data == null ? null : Uint8List.fromList(init.data!));
          }));
    client.connect(rpc);
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
    state?.$2.callNamedFunction(NetworkEvent.user,
        Uint8List.fromList(jsonEncode(user.toJson()).codeUnits));
  }

  bool _externalEvent = false;

  void onEvent(DocumentEvent event) {
    if (!event.shouldSync() || _externalEvent) return;
    state?.$2.callNamedFunction(NetworkEvent.event,
        Uint8List.fromList(jsonEncode(event.toJson()).codeUnits));
  }

  void onMessage(DocumentEvent event) {
    if (!event.shouldSync()) return;
    _externalEvent = true;
    _bloc?.add(event);
    _externalEvent = false;
  }
}
