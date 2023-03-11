import 'package:markdown/markdown.dart' as markdown;

void main() {
  final nodes = markdown.Document().parse("""
# Hello World
This is a test
```dart
void main() {
  print('Hello World');
}
```
""");
  print(nodes.map((e) => e.textContent).join(''));
}
