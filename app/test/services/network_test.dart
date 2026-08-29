import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:butterfly/services/network.dart';
import 'package:networker/networker.dart';
import 'package:networker_socket/client.dart';
import 'package:networker_socket/server.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
}

final class _TestNetworkingService extends NetworkingService {
  void setNetworkState(NetworkState? state) => emit(state);
}
