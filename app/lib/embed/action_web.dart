// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:js_util';

import 'package:js/js.dart';

import 'action.dart';

typedef PushMessageHandler = void Function(String type, Object message);

@JS('pushMessage')
external set _pushMessage(PushMessageHandler f);

void setup() {
  _pushMessage = allowInterop(pushMessage);
}

void pushMessage(String type, Object message) {
  window.dispatchEvent(CustomEvent('receive',
      detail: jsify({'type': type, 'message': message})));
}

void sendEmbedMessage(String type, String message) {
  window.dispatchEvent(
      CustomEvent('message', detail: {'type': type, 'message': message}));
}

EventListener onEmbedMessage(String type, EmbedMessageHandler callback) {
  void listener(event) {
    if (event is CustomEvent && event.detail?.type == type) {
      callback(event.detail.message);
    }
  }

  window.addEventListener('receive', listener);
  return listener;
}

void removeEmbedMessageListener(EventListener listener) {
  window.removeEventListener('receive', listener);
}
