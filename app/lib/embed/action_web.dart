// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:js/js.dart';

import 'action.dart';

typedef PushMessageHandler = void Function(Object message);

@JS('pushMessage')
external set _pushMessage(PushMessageHandler f);

void setup() {
  _pushMessage = allowInterop(pushMessage);
}

void pushMessage(Object message) {
  window.dispatchEvent(CustomEvent('receive', detail: message));
}

class _MessageEvent {
  final String type;
  final String message;
  _MessageEvent(this.type, this.message);
}

void sendEmbedMessage(String type, String message) {
  window.dispatchEvent(
      CustomEvent('message', detail: _MessageEvent(type, message)));
}

EventListener onEmbedMessage(String type, EmbedMessageHandler callback) {
  void listener(event) {
    if (event is CustomEvent && event.detail?.type == type) {
      callback(event.detail);
    }
  }

  window.addEventListener('receive', listener);
  return listener;
}

void removeEmbedMessageListener(EventListener listener) {
  window.removeEventListener('receive', listener);
}
