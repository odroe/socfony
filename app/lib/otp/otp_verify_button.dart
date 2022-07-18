import 'package:flutter/material.dart';

class OtpVerifyButton extends StatelessWidget {
  const OtpVerifyButton({
    super.key,
    required this.text,
    this.callback,
  });

  /// Text of the button.
  final String text;

  /// Called when the button is pressed.
  final void Function(BuildContext context, String otp)? callback;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Text('验证'),
    );
  }
}
