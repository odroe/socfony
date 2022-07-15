class SendOtpSmsOptions {
  final String signName;
  final String templateId;
  final List<String> params;

  const SendOtpSmsOptions({
    this.params = const [],
    required this.signName,
    required this.templateId,
  });
}
