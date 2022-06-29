String? dataTimeReader(Map map, String key) {
  final Object? value = map[key];

  if (value is DateTime) {
    return value.toIso8601String();
  }

  return value?.toString();
}
