import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';

enum NetworkSide { server, client }

enum NetworkType { webSocket, webRtc }

class NetworkService {
  DocumentBloc? bloc;
  NetworkSide? networkSide;
  NetworkType? networkType;

  NetworkService();

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

  void close() {}

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
