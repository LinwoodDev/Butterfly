import 'dart:async';
import 'dart:io';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:rxdart/rxdart.dart';

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
const kTimeout = Duration(seconds: 5);
typedef NetworkingState = (NetworkerBase, RpcPlugin);

class NetworkingInitMessage {
  final List<int>? data;

  NetworkingInitMessage(this.data);
  NetworkingInitMessage.fromJson(Map<String, dynamic> data)
      : data = List<int>.from(data['data']);

  Map<String, dynamic> toJson() => {
        'data': data,
      };
}

class NetworkingService {
  DocumentBloc? _bloc;
  final BehaviorSubject<NetworkingState?> _subject =
      BehaviorSubject.seeded(null);
  final BehaviorSubject<Set<ConnectionId>> _connections =
      BehaviorSubject.seeded({});

  Stream<NetworkingState?> get stream => _subject.stream;
  NetworkingState? get state => _subject.value;

  Stream<Set<ConnectionId>> get connections => _connections.stream;
  Set<ConnectionId> get connectionIds => _connections.value;

  NetworkingService();

  bool get isActive => state != null;

  void setup(DocumentBloc bloc) {
    _bloc = bloc;
  }

  Future<void> createSocketServer([int? port]) async {
    closeNetworking();
    final httpServer = await HttpServer.bind(
      InternetAddress.anyIPv4,
      port ?? kDefaultPort,
    );
    final server = NetworkerSocketServer(httpServer);
    final rpc = RpcNetworkerServerPlugin();
    _setupRpc(rpc, server);
    server.connect.listen((event) {
      final state = _bloc?.state;
      rpc.sendMessage(RpcRequest(
          event, 'init', NetworkingInitMessage(state?.data?.save())));
    });
    server.addPlugin(rpc);
    _subject.add((server, rpc));
  }

  Future<Uint8List?> createSocketClient(Uri uri) async {
    closeNetworking();
    if (!uri.hasPort) {
      uri = uri.replace(port: kDefaultPort);
    }
    final client = NetworkerSocketClient(uri);
    final rpc = RpcNetworkerPlugin();
    _setupRpc(rpc, client);
    final completer = Completer<Uint8List?>();
    rpc.addFunction(
        'init',
        RpcFunction(RpcType.authority, (message) {
          final init = NetworkingInitMessage.fromJson(message.message);
          completer.complete(
              init.data == null ? null : Uint8List.fromList(init.data!));
        }));
    client.addPlugin(RawJsonNetworkerPlugin()..addPlugin(rpc));
    _subject.add((client, rpc));
    return completer.future.timeout(kTimeout);
  }

  void closeNetworking() {
    state?.$1.close();
    _subject.add(null);
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
        RpcFunction(RpcType.any, (message) {
          if (networker is NetworkerServer) {
            rpc.sendMessage(RpcRequest(
                message.client, 'connections', networker.connectionIds));
          } else {
            if (message.client != kNetworkerConnectionIdAuthority) return;
            final ids = Set<ConnectionId>.from(message.message);
            _connections.add(ids);
          }
        }, true));
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
