import 'package:butterfly/embed/embedding.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('internal embedding preserves the user language', () {
    expect(Embedding(internal: true).language, 'user');
  });

  test('full screen embedding is opt-in', () {
    expect(Embedding.fromQuery(const {}).fullScreen, isFalse);
    expect(
      Embedding.fromQuery(const {'fullScreen': 'true'}).fullScreen,
      isTrue,
    );
    expect(
      Embedding.fromQuery(const {'fullScreen': 'false'}).fullScreen,
      isFalse,
    );
  });
}
