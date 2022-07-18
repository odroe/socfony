import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'otp_in_progress_provider.dart';
import 'otp_send.dart';
import 'otp_text_field.dart';
import 'otp_verify_button.dart';

/// Show one-time password verification dialog.
Future<T?> showOtpVerificationDialog<T>(
  BuildContext context, {
  void Function(BuildContext context, String otp)? callback,
  void Function(BuildContext context)? onClose,
  String title = '验证码',
  String? description,
  String buttonText = '验证',
  required String phone,
}) {
  return showDialog<T>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => _OtpVerificationDialog(
      callback: callback,
      title: title,
      description: description,
      onClose: onClose,
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
    this.onClose,
    this.callback,
  }) : super(key: key);

  /// Phone number.
  final String phone;

  /// The callback to be when verification is done.
  final void Function(BuildContext context, String otp)? callback;

  /// User closed the dialog callback.
  final void Function(BuildContext context)? onClose;

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
          _CloseButton(onClose: onClose),
        ],
      ),
      children: [
        _Description(description),
        const OtpTextField(),
        _OtpBottons(
          buttonText: buttonText,
          callback: callback,
        )
      ],
    );
  }
}

/// Close dialog button
class _CloseButton extends ConsumerWidget {
  const _CloseButton({Key? key, this.onClose}) : super(key: key);

  /// on close callback
  final void Function(BuildContext context)? onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a button on pressed callback.
    VoidCallback? onPressed;

    // If one-time password in progress status is false,
    // create a button on pressed callback.
    if (!ref.watch(otpInProgressProvider)) {
      onPressed = () => _onPressed(context, ref);
    }

    return IconButton(
      icon: const Icon(Icons.close),
      onPressed: onPressed,
    );
  }

  /// Close dialog button on pressed callback.
  void _onPressed(BuildContext context, WidgetRef ref) {
    if (onClose != null) {
      return onClose!(context);
    }

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
    this.callback,
  });

  final String buttonText;

  /// The callback to be when verification is done.
  final void Function(BuildContext context, String otp)? callback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const OtpResendButton(),
          OtpVerifyButton(
            text: buttonText,
            callback: callback,
          ),
        ],
      ),
    );
  }
}
