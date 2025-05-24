import 'action_stub.dart'
    if (dart.library.js_interop) 'action_web.dart'
    as embed;

typedef EmbedMessageHandler = void Function(Object? message);
typedef EventListener = Object;

void sendEmbedMessage(String type, Object? message) {
  embed.sendEmbedMessage(type, message);
}

EventListener onEmbedMessage(String type, EmbedMessageHandler callback) {
  return embed.onEmbedMessage(type, callback);
}

void removeEmbedMessageListener(EventListener listener) {
  embed.removeEmbedMessageListener(listener);
}
