abstract class PhoneNumberHelper {
  static String formatChina(String phone) {
    // Validate phone is China phone number, and not empty.
    // Check phone number is China phone number.
    if (!RegExp(r'^1\d{10}$').hasMatch(phone) || phone.length != 11) {
      throw UnimplementedError('手机号码不是正确的中国大陆手机号码');
    }

    // Update phone number to E.164 format.
    return '+86$phone';
  }
}
