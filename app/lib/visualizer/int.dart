extension IntVisualizer on int {
  String toHex({bool leadingHash = true}) {
    var hex = '';
    if (leadingHash) {
      hex += '#';
    }
    hex += toRadixString(16).padLeft(2, '0');
    return hex;
  }
}
