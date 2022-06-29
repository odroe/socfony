class AccessTokenShortMessageServiceOptions {
  final String signName;
  final String templateId;
  final List<String> params;

  const AccessTokenShortMessageServiceOptions({
    this.params = const [],
    required this.signName,
    required this.templateId,
  });
}
