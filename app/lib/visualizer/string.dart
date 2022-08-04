extension StringVisualizer on String {
  String toDisplayString() {
    if (isEmpty) return '';
    return this[0].toUpperCase() +
        substring(1).replaceAllMapped(
            RegExp(r'([A-Z])'), (match) => ' ${match.group(1)?.toLowerCase()}');
  }
}
