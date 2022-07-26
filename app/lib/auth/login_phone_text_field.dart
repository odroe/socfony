import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_in_progress_provider.dart';

/// Login phone number provider.
final AutoDisposeChangeNotifierProvider<TextEditingController>
    loginPhoneNumberProvider =
    ChangeNotifierProvider.autoDispose<TextEditingController>(
        (Ref ref) => TextEditingController());

/// Login phone error text provider.
final AutoDisposeStateProvider<String?> loginPhoneErrorTextProvider =
    StateProvider.autoDispose<String?>((ref) => null);

/// Login phone text field.
class LoginPhoneTextField extends ConsumerWidget {
  const LoginPhoneTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 12),
      child: TextField(
        autofocus: true,
        readOnly: ref.watch(loginInProgressProvider),
        controller: ref.watch(loginPhoneNumberProvider),
        decoration: InputDecoration(
          hintText: '请输入手机号',
          errorText: ref.watch(loginPhoneErrorTextProvider),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
        inputFormatters: [
          // China phone number length formatter.
          LengthLimitingTextInputFormatter(11),

          // Only [0-9] input formatter.
          FilteringTextInputFormatter.digitsOnly,
        ],
        keyboardType: TextInputType.number,
      ),
    );
  }
}
