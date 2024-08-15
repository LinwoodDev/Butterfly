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
  html.window.dispatchEvent(html.MessageEvent(
      'receive',
      html.MessageEventInit(
          data: {'type': type.toDart, 'message': message}.toJSBox)));
}

void sendEmbedMessage(String type, [Object? message]) {
  html.window.dispatchEvent(html.MessageEvent('message',
      html.MessageEventInit(data: {'type': type, 'message': message}.toJSBox)));
}

EventListener onEmbedMessage(String type, EmbedMessageHandler callback) {
  void listener(JSObject event) {
    if (event is html.MessageEvent) {
      final data = event.data;
      if (data is JSObject) {
        final messageType = data.getProperty('type'.toJS).toString();
        final message = data.getProperty('message'.toJS).dartify();
        if (type == messageType) callback(message);
      }
    }
  }

  html.window.addEventListener('receive', listener.toJS);
  return listener.toJS;
}

void removeEmbedMessageListener(EventListener listener) {
  if (listener is! JSFunction) return;
  html.window.removeEventListener('receive', listener);
}
