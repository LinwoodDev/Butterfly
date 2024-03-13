import 'package:uuid/uuid.dart';

String createUniqueId() {
  return Uuid().v8();
}
