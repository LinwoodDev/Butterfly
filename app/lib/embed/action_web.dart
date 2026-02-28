import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:web/web.dart' as html;

import 'action.dart';

@JS('pushMessage')
external set _pushMessage(JSFunction f);

void setup() {
  _pushMessage = pushMessage.toJS;
}

void pushMessage(JSString type, [JSObject? message]) {
  html.window.dispatchEvent(
    html.MessageEvent(
      'receive',
      html.MessageEventInit(
        data: {'type': type.toDart, 'message': message}.jsify(),
      ),
    ),
  );
}

void sendEmbedMessage(String type, [Object? message]) {
  final data = {'type': type, 'message': message}.jsify();
  final parent = html.window.parent;
  if (parent != null && parent != html.window) {
    parent.postMessage(data, '*'.toJS);
  }

  // Also dispatch locally for backwards compatibility
  html.window.dispatchEvent(
    html.MessageEvent('message', html.MessageEventInit(data: data)),
  );
}

EventListener onEmbedMessage(String type, EmbedMessageHandler callback) {
  void listener(html.Event event) {
    if (event.isA<html.MessageEvent>()) {
      final messageEvent = event as html.MessageEvent;
      final data = messageEvent.data;
      if (data.isA<JSObject>()) {
        final objectData = data as JSObject;
        final typeProp = objectData.getProperty('type'.toJS);
        if (typeProp != null) {
          final messageType = typeProp.dartify().toString();
          if (type == messageType) {
            final messageProp = objectData.getProperty('message'.toJS);
            callback(messageProp?.dartify());
          }
        }
      }
    }
  }

  final jsListener = listener.toJS;
  html.window.addEventListener('receive', jsListener);
  html.window.addEventListener('message', jsListener);
  return jsListener;
}

void removeEmbedMessageListener(EventListener listener) {
  // ignore: invalid_runtime_check_with_js_interop_types
  if (listener is! JSFunction) return;
  html.window.removeEventListener('receive', listener);
  html.window.removeEventListener('message', listener);
}
