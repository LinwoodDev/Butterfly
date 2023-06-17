import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly_api/butterfly_api.dart';

enum NetworkType { none, server, client }

class NetworkService {
  DocumentBloc? bloc;

  NetworkService();

  NetworkType get networkType {
    return NetworkType.none;
  }

  void createRtcServer() {}

  void createSocketServer() {}

  void createSocketClient() {}

  void createRtcClient() {}

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
