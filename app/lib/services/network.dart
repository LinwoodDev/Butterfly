import 'dart:async';
import 'dart:convert';
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
typedef NetworkingState = (NetworkerBase, RpcPlugin);

class NetworkingService {
  DocumentBloc? _bloc;
  final BehaviorSubject<NetworkingState?> _subject =
      BehaviorSubject.seeded(null);

  Stream<NetworkingState?> get stream => _subject.stream;
  NetworkingState? get state => _subject.value;

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
    setupRpc(rpc);
    server.addPlugin(rpc);
    _subject.add((server, rpc));
  }

  void createSocketClient(Uri uri) {
    closeNetworking();
    final client = NetworkerSocketClient(uri);
    final rpc = RpcNetworkerPlugin();
    setupRpc(rpc);
    client.addPlugin(RawJsonNetworkerPlugin()..addPlugin(rpc));
    _subject.add((client, rpc));
  }

  void closeNetworking() {
    state?.$1.close();
    _subject.add(null);
  }

  void setupRpc(RpcPlugin rpc) {
    rpc.addFunction(
        'event',
        RpcFunction(RpcType.any, (message) {
          final data = jsonDecode(utf8.decode(message.message));
          final event = DocumentEvent.fromJson(data);
          onMessage(event);
        }));
  }

  void onEvent(DocumentEvent event) {
    if (!event.shouldSync()) return;
    state?.$2.sendMessage(
        RpcRequest(kNetworkerConnectionIdAny, 'event', event.toJson()));
  }

  void onMessage(DocumentEvent event) {
    if (!event.shouldSync()) return;
    _bloc?.add(event);
  }
}
