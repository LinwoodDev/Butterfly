// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:js/js.dart';

import 'action.dart';

typedef PushMessageHandler = void Function(String type, [Object? message]);

@JS('pushMessage')
external set _pushMessage(PushMessageHandler f);

void setup() {
  _pushMessage = allowInterop(pushMessage);
}

void pushMessage(String type, [Object? message]) {
  window.dispatchEvent(
      MessageEvent('receive', data: {'type': type, 'message': message}));
}

void sendEmbedMessage(String type, [Object? message]) {
  window.dispatchEvent(
      MessageEvent('message', data: {'type': type, 'message': message}));
}

EventListener onEmbedMessage(String type, EmbedMessageHandler callback) {
  void listener(event) {
    if (event is MessageEvent && event.data?.type == type) {
      callback(event.data.message);
    }
  }

  window.addEventListener('receive', listener);
  return listener;
}

void removeEmbedMessageListener(EventListener listener) {
  window.removeEventListener('receive', listener);
}
