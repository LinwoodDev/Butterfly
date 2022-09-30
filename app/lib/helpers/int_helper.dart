extension IntHelper on int? {
  int? add(int? value) {
    if (this == null || value == null) return null;
    return this! + value;
  }

  int? subtract(int? value) {
    if (this == null || value == null) return null;
    return this! - value;
  }
}
