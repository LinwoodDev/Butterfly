@TestOn('browser')
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:butterfly/embed/action_web.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:web/web.dart' as html;

void main() {
  const type = 'embed-security-test';
  final parent = html.window.parent!;
  final parentOrigin = html.document.referrer.isEmpty
      ? html.window.location.origin
      : Uri.parse(html.document.referrer).origin;

  void dispatch({JSObject? source, String? origin, Object? data}) {
    html.window.dispatchEvent(
      html.MessageEvent(
        'message',
        html.MessageEventInit(
          source: source,
          origin: origin ?? parentOrigin,
          data: (data ?? {'type': type, 'message': 'request'}).jsify(),
        ),
      ),
    );
  }

  test('only the parent at its original origin can issue commands', () {
    expect(parent, isNot(html.window));
    final messages = <Object?>[];
    final listener = onEmbedMessage(type, messages.add);
    addTearDown(() => removeEmbedMessageListener(listener));
    dispatch();
    dispatch(source: html.window);
    dispatch(source: parent, origin: 'https://untrusted.example');
    dispatch(source: parent, origin: 'null');
    expect(messages, isEmpty);
    dispatch(source: parent);
    expect(messages, ['request']);
  });

  test('outgoing document data uses the pinned parent origin', () {
    final postMessage = parent.getProperty<JSFunction>('postMessage'.toJS);
    final origins = <String>[];
    parent.setProperty(
      'postMessage'.toJS,
      ((JSAny? data, JSString origin) => origins.add(origin.toDart)).toJS,
    );
    try {
      sendEmbedMessage(type, 'private document');
    } finally {
      parent.setProperty('postMessage'.toJS, postMessage);
    }
    expect(origins, [parentOrigin]);
  });

  test('local replies do not execute commands and listeners detach', () {
    final messages = <Object?>[];
    final listener = onEmbedMessage(type, messages.add);
    sendEmbedMessage(type, 'reply');
    expect(messages, isEmpty);
    pushMessage(type.toJS, {'value': 1}.jsify() as JSObject);
    expect(messages, [
      {'value': 1},
    ]);
    removeEmbedMessageListener(listener);
    dispatch(source: parent);
    pushMessage(type.toJS);
    expect(messages, hasLength(1));
  });

  test('malformed command types are ignored', () {
    final messages = <Object?>[];
    final listener = onEmbedMessage('42', messages.add);
    addTearDown(() => removeEmbedMessageListener(listener));
    dispatch(source: parent, data: {'type': 42});
    dispatch(source: parent, data: [type]);
    dispatch(source: parent, data: true);
    expect(messages, isEmpty);
  });
}
