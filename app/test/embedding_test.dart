import 'package:butterfly/embed/embedding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('internal embedding preserves the user language', () {
    expect(Embedding(internal: true).language, 'user');
  });
}
