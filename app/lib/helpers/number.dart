double? parseDoubleInput(String value) {
  final parsed = double.tryParse(value.trim().replaceAll(',', '.'));
  if (parsed == null || !parsed.isFinite) return null;
  return parsed;
}
