import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'otp_common_providers.dart';

/// One-time password text editing controller.
final AutoDisposeChangeNotifierProvider<TextEditingController>
    otpControllerProvider =
    ChangeNotifierProvider.autoDispose<TextEditingController>(
        (Ref ref) => TextEditingController());

/// One-time password error text provider.
final AutoDisposeStateProvider<String?> otpErrorTextProvider =
    StateProvider.autoDispose<String?>((ref) => null);

class OtpTextField extends ConsumerWidget {
  const OtpTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 12),
      child: TextField(
        readOnly: ref.watch(otpVerificationStatusProvider),
        controller: ref.watch(otpControllerProvider),
        decoration: InputDecoration(
          hintText: '请输入验证码',
          errorText: ref.watch(otpErrorTextProvider),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        inputFormatters: [
          // Only [0-9] input formatter.
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
        maxLength: 6,
      ),
    );
  }
}
