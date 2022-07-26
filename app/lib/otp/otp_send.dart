import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../socfony_service.dart';
import '../user/security/account_phone_provider.dart';
import 'otp_common_providers.dart';

/// Is sending status provider.
final AutoDisposeStateProvider<bool> _isSendingProvider =
    StateProvider.autoDispose<bool>((Ref ref) => false);

class OtpResendButton extends ConsumerWidget {
  const OtpResendButton({
    super.key,
    required this.phone,
  });

  final String phone;

  /// Send OTP to phone number.
  void _sendOtpHandler(Reader reader) async {
    // Set sending status.
    reader(_isSendingProvider.state).state = true;

    // Read current authenticated user phone.
    final String? currentPhone = reader(accountPhoneProvider);

    try {
      // Send OTP to phone number.
      if (currentPhone == phone) {
        await socfonyService.sendPhoneOneTimePassword2auth(Empty());
      } else {
        await socfonyService
            .sendPhoneOneTimePassword(StringValue()..value = phone);
      }

      // Reset countdown.
      reader(otpCountdownProvider(phone).notifier).reset();
    } finally {
      // Update sending status.
      reader(_isSendingProvider.state).state = false;
    }
  }

  /// Single tap handler.
  void _onTapHandler(Reader reader) {
    if (!reader(_isSendingProvider)) {
      _sendOtpHandler(reader);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(_isSendingProvider)) {
      return const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(),
      );
    }

    // Watch countdown
    final int countdown = ref.watch(otpCountdownProvider(phone));

    VoidCallback? onPressed;
    String text = '${countdown}s';
    if (countdown == 0) {
      onPressed = () => _onTapHandler(ref.read);
      text = '重新发送';
    }

    // If OTP verify is in progress, disable button.
    if (ref.watch(otpVerificationStatusProvider)) {
      onPressed = null;
    }

    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
