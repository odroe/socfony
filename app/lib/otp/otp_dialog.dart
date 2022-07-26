import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../socfony_service.dart';
import '../user/security/account_phone_provider.dart';
import 'otp_common_providers.dart';
import 'otp_send.dart';
import 'otp_text_field.dart';
import 'otp_verify_button.dart';

/// Show one-time password verification dialog.
Future<String?> showOtpVerificationDialog(
  BuildContext context,
  Reader reader, {
  String title = '验证码',
  String? description,
  String buttonText = '验证',
  required String phone,
}) async {
  // Read current authenticated user phone.
  final String? currentPhone = reader(accountPhoneProvider);

  if (currentPhone == null && phone.isEmpty) {
    throw Exception('Phone is empty.');
  }

  // Read one-time password countdown notifier.
  final OneTimePasswordCountdownNotifier notifier =
      reader(otpCountdownProvider(phone).notifier);

  // If countdown is don't runing, start it.
  if (notifier.isRunning == false) {
    try {
      // Send OTP to phone number.
      if (currentPhone == phone) {
        await socfonyService.sendPhoneOneTimePassword2auth(Empty());
      } else {
        await socfonyService
            .sendPhoneOneTimePassword(StringValue()..value = phone);
      }

      // Reset countdown.
      notifier.reset();
    } catch (e) {
      // Stop countdown.
      notifier.stop();

      // Show error message.
      return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('验证码发送失败，请稍后再试。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('知道了'),
              ),
            ],
          );
        },
      );
    }
  }

  return await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => _OtpVerificationDialog(
      title: title,
      description: description,
      buttonText: buttonText,
      phone: phone,
    ),
  );
}

/// One-time password verification dialog.
class _OtpVerificationDialog extends StatelessWidget {
  const _OtpVerificationDialog({
    Key? key,
    required this.title,
    required this.buttonText,
    required this.phone,
    this.description,
  }) : super(key: key);

  /// Phone number.
  final String phone;

  /// Dialog title.
  final String title;

  /// Dialog description.
  final String? description;

  /// Dialog button text.
  final String buttonText;

  /// Widget build
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Row(
        children: [
          Expanded(child: Text(title)),
          const _CloseButton(),
        ],
      ),
      children: [
        _Description(description),
        const OtpTextField(),
        _OtpBottons(
          buttonText: buttonText,
          phone: phone,
        )
      ],
    );
  }
}

/// Close dialog button
class _CloseButton extends ConsumerWidget {
  const _CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a button on pressed callback.
    VoidCallback? onPressed;

    // If one-time password in progress status is false,
    // create a button on pressed callback.
    if (!ref.watch(otpVerificationStatusProvider)) {
      onPressed = () => _onPressed(context);
    }

    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: onPressed,
    );
  }

  /// Close dialog button on pressed callback.
  void _onPressed(BuildContext context) {
    Navigator.pop(context);
  }
}

/// Description widget.
class _Description extends StatelessWidget {
  const _Description(this.description);

  /// Description text.
  final String? description;

  @override
  Widget build(BuildContext context) {
    if (description == null) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 12),
      child: Text(
        description!,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

/// One-time password buttons.
class _OtpBottons extends StatelessWidget {
  const _OtpBottons({
    required this.buttonText,
    required this.phone,
  });

  final String buttonText;

  /// Phone number.
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: OverflowBar(
        alignment: MainAxisAlignment.spaceBetween,
        children: [
          OtpResendButton(phone: phone),
          OtpVerifyButton(
            text: buttonText,
            phone: phone,
          ),
        ],
      ),
    );
  }
}
