import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(const AssetLocation(path: 'fallback.bfly'));
  });

  test('connection technology recognizes websocket schemes', () {
    expect(
      ConnectionTechnology.fromScheme('ws'),
      ConnectionTechnology.webSocket,
    );
    expect(
      ConnectionTechnology.fromScheme('wss'),
      ConnectionTechnology.webSocket,
    );
    expect(
      ConnectionTechnology.fromScheme('https'),
      ConnectionTechnology.swamp,
    );
  });

  test('setName updates the name used for presence messages', () async {
    final service = NetworkingService();
    addTearDown(service.close);

    service.setName('Ada');

    expect(service.userName, 'Ada');
  });

  test('a socket host uses server-side RPC routing', () async {
    final service = NetworkingService();
    addTearDown(service.close);

    await service.createSocketServer(InternetAddress.loopbackIPv4.address, 0);

    expect(
      service.state?.pipe,
      isA<NamedRpcServerNetworkerPipe<NetworkEvent, NetworkEvent>>(),
    );
  });

  test('a socket client accepts the authority handshake', () async {
    final server = NetworkerSocketServer(InternetAddress.loopbackIPv4, 0);
    final pipe = NamedRpcServerNetworkerPipe<NetworkEvent, NetworkEvent>();
    pipe.registerNamedFunction(NetworkEvent.init);
    server.connect(pipe);
    server.clientConnect.listen((event) {
      pipe.sendNamedFunction(
        NetworkEvent.init,
        Uint8List.fromList([1, 2, 3]),
        channel: event.$1,
      );
    });
    await server.init();
    addTearDown(server.close);
    final service = NetworkingService(timeout: const Duration(seconds: 1));
    addTearDown(service.close);

    final data = await service.createSocketClient(server.address);

    expect(data, [1, 2, 3]);
    expect(
      service.state?.pipe,
      isA<NamedRpcClientNetworkerPipe<NetworkEvent, NetworkEvent>>(),
    );
  });

  test('a client handshake timeout closes the partial session', () async {
    final server = NetworkerSocketServer(InternetAddress.loopbackIPv4, 0);
    await server.init();
    addTearDown(server.close);
    final service = NetworkingService(
      timeout: const Duration(milliseconds: 50),
    );
    addTearDown(service.close);
    final disconnected = server.clientDisconnect.first;

    await expectLater(
      service.createSocketClient(server.address),
      throwsA(isA<TimeoutException>()),
    );
    await disconnected.timeout(const Duration(seconds: 1));

    expect(service.state, isNull);
    expect(service.isActive, isFalse);
    expect(server.clientConnections, isEmpty);
  });

  test('a disconnected client stays read-only', () async {
    final service = _TestNetworkingService();
    final client = NetworkerSocketClient(Uri.parse('ws://localhost'));
    final pipe = NamedRpcClientNetworkerPipe<NetworkEvent, NetworkEvent>();
    service.setNetworkState(
      DisconnectedNetworkState(connection: client, pipe: pipe),
    );
    addTearDown(service.close);

    expect(service.isActive, isFalse);
    expect(service.isClient, isTrue);
    expect(service.sendUndo(), isFalse);
    expect(service.sendRedo(), isFalse);
  });

  test('a new client can undo and redo host history', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    final settings = MockSettingsCubit();
    when(() => settings.state)
        .thenReturn(const ButterflySettings(autosave: false));
    when(() => settings.stream).thenAnswer((_) => const Stream.empty());
    when(() => settings.addRecentHistory(any())).thenAnswer((_) async {});
    final fileSystem = MockButterflyFileSystem(settingsCubit: settings);
    final hostController = EditorController(
      settings,
      TransformCubit(1),
      CameraViewport.unbaked(),
    );
    final hostWindow = WindowCubit(fullScreen: false);
    final (initial, pageName) = NoteData(Archive()).setPage(
      const DocumentPage(layers: [DocumentLayer(id: 'layer')]),
      'Page 1',
    );
    final host = DocumentBloc(
      fileSystem,
      hostController,
      hostWindow,
      initial,
      const AssetLocation(path: 'host.bfly'),
      null,
      initial.getPage(pageName),
      pageName,
    );
    await host.load();
    addTearDown(() async {
      await host.close();
      await hostWindow.close();
    });
    host.add(const DocumentDescriptionChanged(name: 'Changed'));
    await host.stream.firstWhere(
      (state) =>
          state is DocumentLoadSuccess && state.metadata.name == 'Changed',
    );
    expect(host.canUndo, isTrue);

    await hostController.networkingService.createSocketServer(
      InternetAddress.loopbackIPv4.address,
      0,
    );
    final address = hostController.networkingService.state!.connection.address;
    final clientController = EditorController(
      settings,
      TransformCubit(1),
      CameraViewport.unbaked(),
    );
    final bytes = await clientController.networkingService.createSocketClient(
      address,
    );
    final clientData = NoteData.fromData(bytes!);
    final clientWindow = WindowCubit(fullScreen: false);
    final client = DocumentBloc(
      fileSystem,
      clientController,
      clientWindow,
      clientData,
      const AssetLocation(path: 'client.bfly'),
      null,
      clientData.getPage(pageName),
      pageName,
    );
    await client.load();
    addTearDown(() async {
      await client.close();
      await clientWindow.close();
    });
    expect(client.canUndo, isFalse);
    expect(UndoHandler(UndoTool()).getStatus(client), ToolStatus.normal);
    expect(RedoHandler(RedoTool()).getStatus(client), ToolStatus.normal);

    final clientUndone = client.stream.firstWhere(
      (state) =>
          state is DocumentLoadSuccess && state.metadata.name != 'Changed',
    );
    client.sendUndo();
    await host.stream
        .firstWhere(
          (state) =>
              state is DocumentLoadSuccess && state.metadata.name != 'Changed',
        )
        .timeout(const Duration(seconds: 2));
    await clientUndone.timeout(const Duration(seconds: 2));
    expect(host.canRedo, isTrue);

    final clientRedone = client.stream.firstWhere(
      (state) =>
          state is DocumentLoadSuccess && state.metadata.name == 'Changed',
    );
    client.sendRedo();
    await host.stream
        .firstWhere(
          (state) =>
              state is DocumentLoadSuccess && state.metadata.name == 'Changed',
        )
        .timeout(const Duration(seconds: 2));
    await clientRedone.timeout(const Duration(seconds: 2));

    final hostUndoVisibleToClient = client.stream.firstWhere(
      (state) =>
          state is DocumentLoadSuccess && state.metadata.name != 'Changed',
    );
    host.sendUndo();
    await hostUndoVisibleToClient.timeout(const Duration(seconds: 2));

    final hostRedoVisibleToClient = client.stream.firstWhere(
      (state) =>
          state is DocumentLoadSuccess && state.metadata.name == 'Changed',
    );
    host.sendRedo();
    await hostRedoVisibleToClient.timeout(const Duration(seconds: 2));
  });
}

final class _TestNetworkingService extends NetworkingService {
  void setNetworkState(NetworkState? state) => emit(state);
}
