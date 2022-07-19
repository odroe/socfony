import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../socfony_service.dart';
import 'otp_common_providers.dart';
import 'otp_text_field.dart';

class OtpVerifyButton extends ConsumerStatefulWidget {
  const OtpVerifyButton({
    super.key,
    required this.text,
    required this.phone,
  });

  /// Phone number.
  final String phone;

  /// Text of the button.
  final String text;

  @override
  ConsumerState<OtpVerifyButton> createState() => _OtpVerifyButtonState();
}

class _OtpVerifyButtonState extends ConsumerState<OtpVerifyButton> {
  @override
  Widget build(BuildContext context) {
    // If verify in progress, show loading.
    if (ref.watch(otpVerificationStatusProvider)) {
      return const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(),
      );
    }

    return TextButton(
      onPressed: () => _onTapHandler(context, ref),
      child: Text(widget.text),
    );
  }

  /// Single tap handler.
  void _onTapHandler(BuildContext context, WidgetRef ref) {
    if (!ref.read(otpVerificationStatusProvider)) {
      _onVerify(context, ref);
    }
  }

  // Verify One-time password and run callback.
  void _onVerify(BuildContext context, WidgetRef ref) async {
    // Update verify in progress status to true.
    ref.read(otpVerificationStatusProvider.state).state = true;

    // Read one-time password.
    final String otp = ref.read(otpControllerProvider).text;

    // Clear error message.
    ref.read(otpErrorTextProvider.state).state = null;

    try {
      // Verify one-time password.
      final BoolValue verified = await socfonyService
          .checkPhoneOneTimePassword(CheckPhoneOneTimePasswordRequest()
            ..phone = widget.phone
            ..otp = otp);

      // Update verify in progress status to false.
      ref.read(otpVerificationStatusProvider.state).state = false;

      // If verified is false, show error.
      if (verified.value == false) {
        ref.read(otpErrorTextProvider.state).state = '验证码错误';

        return;
      }
    } catch (e) {
      ref.read(otpErrorTextProvider.state).state = '验证失败，请重试';
      // Update verify in progress status to false.
      ref.read(otpVerificationStatusProvider.state).state = false;

      return;
    }

    if (mounted) {
      Navigator.of(context).pop(otp);
    }
  }
}
