import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../socfony_service.dart';
import 'otp_common_providers.dart';

class OtpResendButton extends ConsumerStatefulWidget {
  const OtpResendButton({super.key, required this.phone});

  /// Phone number.
  final String phone;

  @override
  ConsumerState<OtpResendButton> createState() => _OtpResendButtonState();
}

/// Is sending status provider.
final AutoDisposeStateProvider<bool> _isSendingProvider =
    StateProvider.autoDispose<bool>((Ref ref) => false);

class _OtpResendButtonState extends ConsumerState<OtpResendButton> {
  Timer? _timer;

  bool get _isSending => ref.watch(_isSendingProvider);

  @override
  void initState() {
    super.initState();

    // _sendOtpHandler();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// Send OTP to phone number.
  void _sendOtpHandler() async {
    // Set sending status.
    ref.read(_isSendingProvider.state).state = true;

    try {
      // Send OTP to phone number.
      await socfonyService
          .sendPhoneOneTimePassword(StringValue()..value = widget.phone);

      // Reset countdown.
      ref.read(otpCountdownProvider(widget.phone).notifier).reset();
    } finally {
      // Update sending status.
      ref.read(_isSendingProvider.state).state = false;
    }
  }

  /// Single tap handler.
  void _onTapHandler() {
    if (!ref.read(_isSendingProvider)) {
      _sendOtpHandler();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isSending) {
      return const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(),
      );
    }

    // Watch countdown
    final int countdown = ref.watch(otpCountdownProvider(widget.phone));

    VoidCallback? onPressed;
    String text = '${countdown}s';
    if (countdown == 0) {
      onPressed = _onTapHandler;
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
