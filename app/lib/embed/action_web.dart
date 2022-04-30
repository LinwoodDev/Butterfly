// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'action.dart';

void sendEmbedMessage(String type, Object message) {
  window.dispatchEvent(CustomEvent('message', detail: {
    'type': type,
    'message': message,
  }));
}

EventListener onEmbedMessage(String type, EmbedMessageHandler callback) {
  void listener(event) {
    if (event is CustomEvent &&
        event.detail is Map &&
        event.detail['type'] == type) {
      callback(event.detail['message']);
    }
  }

  window.addEventListener('message', listener);
  return listener;
}

void removeEmbedMessageListener(EventListener listener) {
  window.removeEventListener('message', listener);
}
