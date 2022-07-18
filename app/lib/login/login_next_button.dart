import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_agrements_widget.dart';
import 'login_in_progress_provider.dart';
import 'login_phone_text_field.dart';

/// Login next button.
class LoginNextButton extends ConsumerWidget {
  const LoginNextButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a button on pressed callback.
    VoidCallback? onPressed;

    // Read agrements status.
    final bool agrementsStatus = ref.watch(loginAgrementsStatusProvider);

    // Read the login in progress status.
    final bool loginInProgress = ref.watch(loginInProgressProvider);

    // Create button child.
    late final Widget child;

    // If login in progress status is true, create a loading child.
    if (loginInProgress) {
      child = const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else {
      child = const Text('下一步');
    }

    // If login in progress status is false, and agrements status is true,
    // create a button on pressed callback.
    if (loginInProgress == false && agrementsStatus == true) {
      onPressed = () => _onPressed(context, ref);
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
      ),
    );
  }

  /// On pressed callback.
  void _onPressed(BuildContext context, WidgetRef ref) async {
    // Read phone number.
    final String phone = ref.read(loginPhoneNumberProvider).text;

    // Validate phone is China phone number, and not empty.
    //
    // If phone is not valid, show error message and return void.
    if (!_phoneValidator(ref, phone)) return;

    // Set login in progress status to true.
    ref.read(loginInProgressProvider.state).state = true;
  }

  /// Phone validator.
  bool _phoneValidator(WidgetRef ref, String phone) {
    // if phone is empty
    if (phone.isEmpty) {
      // Set phone field error.
      ref.read(loginPhoneErrorTextProvider.state).state = '手机号不能为空';

      return false;

      // if phone is not china phone number
    } else if (!_isChinaPhoneNumber(phone)) {
      // Set phone field error.
      ref.read(loginPhoneErrorTextProvider.state).state = '请输入正确的手机号';

      return false;
    }

    // Clear phone field error.
    ref.read(loginPhoneErrorTextProvider.state).state = null;

    return true;
  }

  /// Is china phone number.
  bool _isChinaPhoneNumber(String phone) =>
      RegExp(r'^1\d{10}$').hasMatch(phone);
}
