// ========== DOUBLE converters ==========
/// For non‑nullable double fields (throws if null)
double stringToDouble(dynamic value) {
  if (value == null) throw ArgumentError('Expected double, got null');
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.parse(value);
  throw ArgumentError('Cannot convert $value to double');
}

/// For nullable double fields
double? stringToDoubleNullable(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

String? doubleToStringNullable(double? value) => value?.toString();

// ========== INTEGER converters ==========
/// For non‑nullable int fields (throws if null)
int stringToInt(dynamic value) {
  if (value == null) throw ArgumentError('Expected int, got null');
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.parse(value);
  throw ArgumentError('Cannot convert $value to int');
}

/// For nullable int fields
int? stringToIntNullable(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

String? intToStringNullable(int? value) => value?.toString();