// Current only support Chinese phone number.
class PhoneNumber {
  const PhoneNumber(this.phone);

  /// original phone number.
  final String phone;

  /// Get phone number in E.164 format.
  String get e164 {
    // If phone start with '+', return it.
    if (phone.startsWith('+')) {
      return phone;
    }

    // Validate phone is China phone number, and not empty.
    // Check phone number is China phone number.
    if (!RegExp(r'^1\d{10}$').hasMatch(phone) || phone.length != 11) {
      throw UnimplementedError(
          'phone number without international code only support Chinese phone phone number');
    }

    // Update phone number to E.164 format.
    return '+86$phone';
  }

  /// Desensitization phone number.
  String get desensitization => phone.replaceRange(5, 10, '****');

  @override
  String toString() => e164;
}
