extension MapExt on Map<String, dynamic> {
  Map<String, dynamic> removeValue(dynamic value) {
    removeWhere((k, v) => v == value);
    return this;
  }

  Map<String, dynamic> get removeNulls {
    removeWhere((key, value) => value == null);
    return this;
  }

  Map<String, dynamic> get removeEmpties => removeValue('');

  Map<String, dynamic> get removeFalseOrNull {
    removeWhere(
      (key, value) =>
          value == false || value == null || (value is List && value.isEmpty),
    );

    return this;
  }

  Map<String, dynamic>? get emptyNull {
    if (isEmpty) return null;
    return this;
  }
}
