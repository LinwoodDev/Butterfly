import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lib5/util.dart';
import 'package:lib5_crypto_implementation_dart/lib5_crypto_implementation_dart.dart';
import 'package:networker/networker.dart';
import 'package:networker_s5/networker_s5.dart';
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
  webRtc,
  s5;

  Future<bool> isCompatible() async => switch (this) {
        NetworkingType.webRtc => kIsWeb ||
            !Platform.isAndroid ||
            (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 28,
        NetworkingType.webSocket => !kIsWeb,
        NetworkingType.s5 => true,
      };
}

const kDefaultPort = 28005;
const kTimeout = Duration(seconds: 10);
typedef NetworkingState = (NetworkerBase, RpcPlugin);

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

class NetworkingService {
  DocumentBloc? _bloc;
  final BehaviorSubject<NetworkingState?> _subject =
      BehaviorSubject.seeded(null);
  final BehaviorSubject<Set<ConnectionId>> _connections =
      BehaviorSubject.seeded({});
  final BehaviorSubject<Map<ConnectionId, NetworkingUser>> _users =
      BehaviorSubject.seeded({});

  Stream<NetworkingState?> get stream => _subject.stream;
  NetworkingState? get state => _subject.value;

  Stream<Set<ConnectionId>> get connectionsStream => _connections.stream;
  Set<ConnectionId> get connections => _connections.value;

  Stream<Map<ConnectionId, NetworkingUser>> get usersStream => _users.stream;
  Map<ConnectionId, NetworkingUser> get users => _users.value;

  NetworkingService();

  bool get isActive => state != null;

  void setup(DocumentBloc bloc) {
    _bloc = bloc;
  }

  Future<void> createSocketServer([String? address, int? port]) async {
    closeNetworking();
    final httpServer = await HttpServer.bind(
      address != null
          ? InternetAddress(address, type: InternetAddressType.any)
          : InternetAddress.anyIPv4,
      port ?? kDefaultPort,
    );
    final server = NetworkerSocketServer(httpServer);
    final rpc = RpcNetworkerServerPlugin();
    _setupRpc(rpc, server);
    void sendConnections() {
      rpc.sendMessage(RpcRequest(
          kNetworkerConnectionIdAny, 'connections', server.connectionIds));
    }

    server.connect.listen((event) {
      final state = _bloc?.state;
      rpc.sendMessage(
          RpcRequest(event, 'init', NetworkingInitMessage(state?.saveBytes())));
      sendConnections();
    });
    server.disconnect.listen((event) {
      sendConnections();
    });
    server.addPlugin(rpc);
    _subject.add((server, rpc));
  }

  Future<Uint8List?> createClient(Uri uri) async {
    return switch (uri.scheme) {
      'ws' => createSocketClient(uri),
      'wss' => createSocketClient(uri),
      's5-stream' => createS5(uri),
      _ => throw UnsupportedError('Unsupported scheme ${uri.scheme}'),
    };
  }

  Future<Uint8List?> _setupClient(NetworkerClient client,
      [bool initiator = false]) async {
    await client.init();
    client.read.listen((event) {
      print('Got: ${String.fromCharCodes(event)}');
    });
    final rpc = RpcNetworkerPlugin();
    _setupRpc(rpc, client);
    final completer = Completer<Uint8List?>();
    client.addPlugin(RawJsonNetworkerPlugin()..addPlugin(rpc));
    _subject.add((client, rpc));
    if (!initiator) {
      rpc.addFunction(
          'init',
          RpcFunction(RpcType.authority, (message) {
            final init = NetworkingInitMessage.fromJson(message.message);
            completer.complete(
                init.data == null ? null : Uint8List.fromList(init.data!));
          }));
      return completer.future.timeout(kTimeout);
    }
    rpc.sendMessage(RpcRequest(kNetworkerConnectionIdAny, 'init',
        NetworkingInitMessage(_bloc?.state.saveBytes())));
    return null;
  }

  Future<Uint8List?> createSocketClient(Uri uri) async {
    closeNetworking();
    if (!uri.hasPort) {
      uri = uri.replace(port: kDefaultPort);
    }
    final client = NetworkerSocketClient(uri);
    return _setupClient(client);
  }

  Future<Uint8List?> createS5([Uri? uri]) async {
    final crypto = DartCryptoImplementation();
    var initiator = uri == null;
    uri ??= Uri(
      scheme: 's5-stream',
      host: 'encrypted',
      userInfo: base64UrlNoPaddingEncode(crypto.generateRandomBytes(32)),
    );
    final s5 = NetworkerS5({}, uri);
    return _setupClient(s5, initiator);
  }

  void closeNetworking() {
    state?.$1.close();
    _subject.add(null);
    _connections.add({});
    _users.add({});
  }

  void _setupRpc(RpcPlugin rpc, NetworkerBase networker) {
    rpc.addFunction(
        'event',
        RpcFunction(RpcType.any, (message) {
          final event = DocumentEvent.fromJson(message.message);
          onMessage(event);
        }));
    rpc.addFunction(
        'connections',
        RpcFunction(RpcType.authority, (message) {
          final ids = Set<ConnectionId>.from(message.message);
          _connections.add(ids);
          _users.add(Map.from(_users.value)
            ..removeWhere((key, value) => !ids.contains(key)));
        }, true));
    rpc.addFunction(
        'user',
        RpcFunction(RpcType.any, (message) {
          final user = NetworkingUser.fromJson(message.message);
          final users = Map<ConnectionId, NetworkingUser>.from(_users.value)
            ..[message.client ?? 0] = user;
          _users.add(users);
          _bloc?.state.currentIndexCubit?.updateNetworkingState(_bloc!, users);
        }));
  }

  void sendUser(NetworkingUser user) {
    state?.$2.sendMessage(
        RpcRequest(kNetworkerConnectionIdAny, 'user', user.toJson()));
  }

  bool _externalEvent = false;

  void onEvent(DocumentEvent event) {
    if (!event.shouldSync() || _externalEvent) return;
    state?.$2.sendMessage(
        RpcRequest(kNetworkerConnectionIdAny, 'event', event.toJson()));
  }

  void onMessage(DocumentEvent event) {
    if (!event.shouldSync()) return;
    _externalEvent = true;
    _bloc?.add(event);
    _externalEvent = false;
  }
}
