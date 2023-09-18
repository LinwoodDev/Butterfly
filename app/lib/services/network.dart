import 'dart:io';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

enum NetworkSide { server, client }

enum NetworkType {
  webSocket,
  webRtc;

  Future<bool> isCompatible() async => switch (this) {
        NetworkType.webRtc => kIsWeb ||
            !Platform.isAndroid ||
            (await DeviceInfoPlugin().androidInfo).version.sdkInt >= 28,
        NetworkType.webSocket => !kIsWeb,
      };
}

class NetworkService {
  DocumentBloc? bloc;
  NetworkSide? networkSide;
  NetworkType? networkType;

  NetworkService();

  bool get isActive => networkSide != null && networkType != null;

  void createRtcServer() {
    close();
    networkSide = NetworkSide.server;
    networkType = NetworkType.webRtc;
  }

  void createSocketServer() {
    close();
    networkSide = NetworkSide.server;
    networkType = NetworkType.webSocket;
  }

  void createSocketClient() {
    close();
    networkSide = NetworkSide.client;
    networkType = NetworkType.webSocket;
  }

  void createRtcClient() {
    close();
    networkSide = NetworkSide.client;
    networkType = NetworkType.webRtc;
  }

  void close() {
    networkSide = null;
    networkType = null;
  }

  void onEvent(DocumentEvent event) {
    if (!event.shouldSync()) return;
    // TODO: implement send
  }

  void onMessage(DocumentEvent event) {
    if (!event.shouldSync()) return;
    bloc?.add(event);
  }

  void setup(DocumentBloc bloc) {
    this.bloc = bloc;
  }
}
