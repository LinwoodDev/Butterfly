import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/models/viewport.dart';
import 'package:butterfly/renderers/cursors/user.dart';
import 'package:butterfly/services/network.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
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

  test('session options override defaults until the session stops', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final settings = SettingsCubit(prefs);
    final service = NetworkingService(settingsCubit: settings);
    addTearDown(settings.close);
    addTearDown(service.close);
    const defaults = CollaborationSettings(showCursor: false);
    const session = CollaborationSettings(syncToolbar: true);
    await settings.changeCollaborationSettings(defaults);
    expect(service.settings, defaults);

    service.setSessionSettings(session);
    expect(service.settings, session);
    expect(ButterflySettings.fromPrefs(prefs).collaboration, defaults);
    await service.createSocketServer(InternetAddress.loopbackIPv4.address, 0);
    expect(service.settings, session);
    await service.closeNetworking();
    expect(service.settings, defaults);

    await settings.changeCollaborationSettings(const CollaborationSettings());
    expect(service.settings, const CollaborationSettings());
  });

  test(
    'toolbar, page and area switches control both network directions',
    () async {
      var data = NoteData(Archive())
          .setInfo(DocumentInfo(tools: [HandTool(id: 'initial')]));
      final page = DocumentPage(
        layers: const [DocumentLayer(id: 'layer')],
        areas: [
          Area(
            name: 'Area',
            width: 100,
            height: 100,
            position: const Point(0, 0),
          ),
        ],
      );
      final (firstData, firstPage) = data.setPage(page, 'First');
      final (initial, secondPage) = firstData.setPage(page, 'Second');
      final host = await _createPeer(initial, firstPage);
      addTearDown(host.close);
      final hostService = host.controller.networkingService;
      await hostService.createSocketServer(
        InternetAddress.loopbackIPv4.address,
        0,
      );
      final clientService = NetworkingService();
      final bytes = await clientService.createSocketClient(
        hostService.state!.connection.address,
      );
      final client = await _createPeer(
        NoteData.fromData(bytes!),
        firstPage,
        clientService,
      );
      addTearDown(client.close);
      const enabled = CollaborationSettings(
        syncToolbar: true,
        syncCurrentPage: true,
        syncCurrentArea: true,
      );

      // One participant enabling synchronization must not override the other's
      // preference, whether the sender or the receiver has opted out.
      for (var i = 0; i < 2; i++) {
        hostService.setSessionSettings(
          i == 0 ? enabled : const CollaborationSettings(),
        );
        clientService.setSessionSettings(
          i == 0 ? const CollaborationSettings() : enabled,
        );
        host.bloc.add(ToolsReplaced([PenTool(id: 'tool-$i')]));
        await host.bloc.stream.firstWhere(
          (state) => state.info?.tools.single.id == 'tool-$i',
        );
        final pageName = i == 0 ? secondPage : firstPage;
        host.bloc.add(PageChanged(pageName));
        await host.bloc.stream.firstWhere(
          (state) => state.pageName == pageName,
        );
        host.bloc.add(
          CurrentAreaChanged('Area', pageName: host.bloc.state.pageName),
        );
        await host.bloc.stream.firstWhere(
          (state) =>
              state is DocumentLoadSuccess && state.currentAreaName == 'Area',
        );
        final received = client.bloc.stream.firstWhere(
          (state) => state.metadata?.name == 'marker-$i',
        );
        host.bloc.add(DocumentDescriptionChanged(name: 'marker-$i'));
        await received.timeout(const Duration(seconds: 2));
        final state = client.bloc.state as DocumentLoadSuccess;
        expect(state.info.tools.single.id, 'initial');
        expect(state.pageName, firstPage);
        expect(state.currentAreaName, isEmpty);
      }

      hostService.setSessionSettings(enabled);
      clientService.setSessionSettings(enabled);
      final toolbarReceived = client.bloc.stream.firstWhere(
        (state) => state.info?.tools.single.id == 'shared',
      );
      host.bloc.add(ToolsReplaced([PenTool(id: 'shared')]));
      await toolbarReceived.timeout(const Duration(seconds: 2));
      final pageReceived = client.bloc.stream.firstWhere(
        (state) => state.pageName == secondPage,
      );
      host.bloc.add(PageChanged(secondPage));
      await pageReceived.timeout(const Duration(seconds: 2));
      final areaReceived = client.bloc.stream.firstWhere(
        (state) =>
            state is DocumentLoadSuccess && state.currentAreaName == 'Area',
      );
      host.bloc.add(
        CurrentAreaChanged('Area', pageName: host.bloc.state.pageName),
      );
      await areaReceived.timeout(const Duration(seconds: 2));

      // Shared undo/redo snapshots also respect a participant's local toolbar.
      clientService.setSessionSettings(const CollaborationSettings());
      client.bloc.add(ToolsReplaced([HandTool(id: 'local')]));
      await client.bloc.stream.firstWhere(
        (state) => state.info?.tools.single.id == 'local',
      );
      final snapshotReceived = client.bloc.stream.first;
      await hostService.sendInit();
      await snapshotReceived.timeout(const Duration(seconds: 2));
      expect(client.bloc.state.info?.tools.single.id, 'local');
      expect(
        (client.bloc.state as DocumentLoadSuccess).currentAreaName,
        'Area',
      );
    },
  );

  test(
    'edits follow their page and layer while navigation stays local',
    () async {
      const page = DocumentPage(
        layers: [
          DocumentLayer(id: 'bottom'),
          DocumentLayer(id: 'top'),
        ],
        areas: [
          Area(name: 'region', width: 100, height: 100, position: Point(0, 0)),
        ],
      );
      final (firstData, firstPage) = NoteData(Archive()).setPage(page, 'First');
      final (data, secondPage) = firstData.setPage(page, 'Second');
      final host = await _createPeer(data, firstPage);
      addTearDown(host.close);
      final hostService = host.controller.networkingService;
      await hostService.createSocketServer(
        InternetAddress.loopbackIPv4.address,
        0,
      );
      final clientService = NetworkingService();
      final bytes = await clientService.createSocketClient(
        hostService.state!.connection.address,
      );
      final client = await _createPeer(
        NoteData.fromData(bytes!),
        firstPage,
        clientService,
      );
      addTearDown(client.close);

      final presenceReceived = clientService.usersStream.firstWhere(
        (users) => users.values.any((user) => user.name == '共同作業 🦋'),
      );
      hostService.setName('共同作業 🦋');
      await presenceReceived.timeout(const Duration(seconds: 2));

      host.bloc.add(PageChanged(secondPage));
      await host.bloc.stream.firstWhere(
        (state) => state.pageName == secondPage,
      );
      host.bloc.add(const CurrentLayerChanged('bottom'));
      await host.bloc.stream.firstWhere(
        (state) => state.currentLayer == 'bottom',
      );
      final received = client.bloc.stream.firstWhere(
        (state) =>
            state.data
                ?.getPage(secondPage)
                ?.content
                .any((e) => e.id == 'remote') ==
            true,
      );
      host.bloc.add(
        ElementsCreated(
          [
            ShapeElement(
              id: 'remote',
              firstPosition: const Point(1, 1),
              secondPosition: const Point(10, 10),
            ),
          ],
          pageName: host.bloc.state.pageName,
          layer: host.bloc.state.currentLayer,
        ),
      );
      await received.timeout(const Duration(seconds: 2));
      expect(client.bloc.state.pageName, firstPage);
      expect(client.bloc.state.page!.content, isEmpty);
      expect(client.bloc.state.currentLayer, 'top');
      expect(
        client.bloc.state.data!
            .getPage(secondPage)!
            .getLayer('bottom')
            .content
            .single
            .id,
        'remote',
      );

      final moved = client.bloc.stream.firstWhere(
        (state) =>
            (state.data?.getPage(secondPage)?.content.singleOrNull
                    as ShapeElement?)
                ?.firstPosition ==
            const Point(21, 1),
      );
      host.bloc.add(
        AreaChanged(
          'region',
          Area(name: 'region', width: 100, height: 100, position: Point(20, 0)),
          true,
          host.bloc.state.pageName,
        ),
      );
      await moved.timeout(const Duration(seconds: 2));
      final changed = client.bloc.stream.firstWhere(
        (state) =>
            (state.data?.getPage(secondPage)?.content.singleOrNull
                    as ShapeElement?)
                ?.firstPosition ==
            const Point(25, 5),
      );
      host.bloc.add(
        ElementsChanged({
          'remote': [
            ShapeElement(
              id: 'remote',
              firstPosition: const Point(25, 5),
              secondPosition: const Point(35, 15),
            ),
          ],
        }, pageName: host.bloc.state.pageName),
      );
      await changed.timeout(const Duration(seconds: 2));
      final areasRemoved = client.bloc.stream.firstWhere(
        (state) =>
            state.page!.areas.isEmpty &&
            state.data!.getPage(secondPage)!.areas.isEmpty,
      );
      host.bloc.add(
        AreasRemoved([
          AreaPreset(page: firstPage, name: 'region'),
          AreaPreset(page: secondPage, name: 'region'),
        ]),
      );
      await areasRemoved.timeout(const Duration(seconds: 2));

      final renamed = client.bloc.stream.firstWhere(
        (state) =>
            state.data?.getPage(secondPage)?.getLayer('bottom').name ==
            '共同作業 🦋',
      );
      host.bloc.add(
        LayerChanged(
          'bottom',
          name: '共同作業 🦋',
          pageName: host.bloc.state.pageName,
        ),
      );
      await renamed.timeout(const Duration(seconds: 2));
      final removed = client.bloc.stream.firstWhere(
        (state) => state.data?.getPage(secondPage)?.content.isEmpty == true,
      );
      host.bloc.add(
        ElementsRemoved(['remote'], pageName: host.bloc.state.pageName),
      );
      await removed.timeout(const Duration(seconds: 2));

      // The selected layer also stays local when everyone views the same page.
      client.bloc.add(PageChanged(secondPage));
      await client.bloc.stream.firstWhere(
        (state) => state.pageName == secondPage,
      );
      final activeReceived = client.bloc.stream.firstWhere(
        (state) => state.page?.content.any((e) => e.id == 'active') == true,
      );
      host.bloc.add(
        ElementsCreated(
          [PenElement(id: 'active')],
          pageName: host.bloc.state.pageName,
          layer: host.bloc.state.currentLayer,
        ),
      );
      await activeReceived.timeout(const Duration(seconds: 2));
      expect(client.bloc.state.currentLayer, 'top');
      expect(
        client.bloc.state.page!.getLayer('bottom').content.single.id,
        'active',
      );

      final newPageReceived = client.bloc.stream.firstWhere(
        (state) => state.data!.getPages().length == 3,
      );
      host.bloc.add(
        const PagesAdded([
          PageAddedDetails(name: 'Third', page: DocumentPage()),
        ]),
      );
      await newPageReceived.timeout(const Duration(seconds: 2));
      final hostPage = host.bloc.state.pageName;
      expect(hostPage, isNot(secondPage));
      expect(client.bloc.state.pageName, hostPage);
      client.bloc.add(PageChanged(secondPage));
      await client.bloc.stream.firstWhere(
        (state) => state.pageName == secondPage,
      );
      final reverseReceived = host.bloc.stream.firstWhere(
        (state) =>
            state.data
                ?.getPage(secondPage)
                ?.content
                .any((e) => e.id == 'from-client') ==
            true,
      );
      client.bloc.add(
        ElementsCreated(
          [PenElement(id: 'from-client')],
          pageName: client.bloc.state.pageName,
          layer: client.bloc.state.currentLayer,
        ),
      );
      await reverseReceived.timeout(const Duration(seconds: 2));
      expect(host.bloc.state.pageName, hostPage);
      expect(host.bloc.state.page!.content, isEmpty);

      // The typed target is authoritative even when neither peer views it.
      final areaReceived = client.bloc.stream.firstWhere(
        (state) =>
            state.data?.getPage(firstPage)?.areas.singleOrNull?.name ==
            'offscreen',
      );
      host.bloc.add(
        AreasCreated([
          AreaPreset(
            page: firstPage,
            area: const Area(
              name: 'offscreen',
              width: 100,
              height: 100,
              position: Point(0, 0),
            ),
          ),
        ]),
      );
      await areaReceived.timeout(const Duration(seconds: 2));
      expect(
        host.bloc.state.data!.getPage(firstPage)!.areas.single.name,
        'offscreen',
      );
      expect(host.bloc.state.pageName, hostPage);
      expect(client.bloc.state.pageName, secondPage);
      expect(host.bloc.state.page!.areas, isEmpty);
      expect(client.bloc.state.page!.areas, isEmpty);
    },
  );

  test(
    'cursor and live-preview visibility are independent and reversible',
    () async {
      final (data, pageName) = NoteData(Archive()).setPage(
        const DocumentPage(layers: [DocumentLayer(id: 'layer')]),
        'Page',
      );
      final service = _TestNetworkingService();
      final peer = await _createPeer(data, pageName, service);
      addTearDown(peer.close);
      final controller = peer.controller;
      final preview = PenElement(id: 'preview');
      service.currentUsers = <Channel, NetworkingUser>{
        1: NetworkingUser(cursor: const Point(10, 20), foreground: [preview]),
      };
      Future<void> refresh() => controller.updateNetworkingState(peer.bloc);
      await refresh();
      expect(controller.toolCubit.state.networkingForegrounds, hasLength(2));

      service.currentUsers = {
        1: NetworkingUser(
          pageName: 'another page',
          cursor: const Point(10, 20),
          foreground: [preview],
        ),
      };
      await refresh();
      expect(controller.toolCubit.state.networkingForegrounds, isEmpty);
      service.currentUsers = {
        1: NetworkingUser(
          pageName: pageName,
          cursor: const Point(10, 20),
          foreground: [preview],
        ),
      };
      await refresh();
      expect(controller.toolCubit.state.networkingForegrounds, hasLength(2));

      controller.networkingService.setSessionSettings(
        const CollaborationSettings(showCursor: false),
      );
      await refresh();
      expect(
        controller.toolCubit.state.networkingForegrounds
            .whereType<UserCursor>(),
        isEmpty,
      );
      expect(
        controller.toolCubit.state.networkingForegrounds.single.element,
        preview,
      );

      controller.networkingService.setSessionSettings(
        const CollaborationSettings(showTemporary: false),
      );
      await refresh();
      expect(
        controller.toolCubit.state.networkingForegrounds.single,
        isA<UserCursor>(),
      );

      controller.networkingService.setSessionSettings(
        const CollaborationSettings(),
      );
      await refresh();
      expect(controller.toolCubit.state.networkingForegrounds, hasLength(2));
    },
  );

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
  Map<Channel, NetworkingUser>? currentUsers;
  @override
  Map<Channel, NetworkingUser> get users => currentUsers ?? super.users;
  void setNetworkState(NetworkState? state) => emit(state);
}

class _Peer {
  final DocumentBloc bloc;
  final EditorController controller;
  final WindowCubit window;
  _Peer(this.bloc, this.controller, this.window);

  Future<void> close() async {
    await bloc.close();
    await window.close();
  }
}

Future<_Peer> _createPeer(
  NoteData data,
  String pageName, [
  NetworkingService? service,
]) async {
  final settings = MockSettingsCubit();
  when(() => settings.state)
      .thenReturn(const ButterflySettings(autosave: false));
  when(() => settings.stream).thenAnswer((_) => const Stream.empty());
  when(() => settings.addRecentHistory(any())).thenAnswer((_) async {});
  final controller = EditorController(
    settings,
    TransformCubit(1),
    CameraViewport.unbaked(),
    networkingService: service,
  );
  final window = WindowCubit(fullScreen: false);
  final bloc = DocumentBloc(
    MockButterflyFileSystem(settingsCubit: settings),
    controller,
    window,
    data,
    const AssetLocation(path: 'peer.bfly'),
    null,
    data.getPage(pageName),
    pageName,
  );
  await bloc.load();
  return _Peer(bloc, controller, window);
}
