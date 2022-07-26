import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../otp/otp_dialog.dart';
import '../user/user_providers.dart';
import '../socfony_service.dart';
import 'auth_provider.dart';
import 'login_agrements_widget.dart';
import 'login_in_progress_provider.dart';
import 'login_phone_text_field.dart';

/// Login next button.
class LoginNextButton extends ConsumerStatefulWidget {
  const LoginNextButton({super.key});

  @override
  ConsumerState<LoginNextButton> createState() => _LoginNextButtonState();
}

class _LoginNextButtonState extends ConsumerState<LoginNextButton> {
  @override
  Widget build(BuildContext context) {
    // Create a button on pressed callback.
    VoidCallback? onPressed;

    // Read agrements status.
    final bool agrementsStatus = ref.watch(loginAgrementsStatusProvider);

    // Read the login in progress status.
    final bool loginInProgress = ref.watch(loginInProgressProvider);

    // Create button child.
    Widget child = const Text('下一步');

    // If login in progress status is true, create a loading child.
    if (loginInProgress) {
      child = const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    // If login in progress status is false, and agrements status is true,
    // create a button on pressed callback.
    if (loginInProgress == false && agrementsStatus == true) {
      onPressed = () => _onPressed(context, ref);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: OverflowBar(
        alignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onPressed,
            child: child,
          ),
        ],
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

    // Request one-time password.
    final String? otp = await showOtpVerificationDialog(
      context,
      ref.read,
      phone: phone,
      description: '如果你的手机号码未注册，验证完成后将自动创建账户。',
      buttonText: r'完成',
    );

    // If otp is null, set in progress status to false.
    if (otp == null) {
      ref.read(loginInProgressProvider.state).state = false;
      return;
    }

    try {
      // Create access token.
      final AccessToken accessToken =
          await socfonyService.createAccessToken(CreateAccessTokenRequest()
            ..phone = phone
            ..otp = otp);

      // Save access token to local storage.
      await writeAccessToken(accessToken);

      // Fetch remote user.
      final User user = await socfonyService
          .findUser(StringValue()..value = accessToken.userId);

      // Save user to user's provider.
      user.save(ref.read);
      ref.read(authenticatedProvider.notifier).update(accessToken.userId);

      // Navigate to back.
      if (mounted) {
        Navigator.of(context).pop<User>(user);
      }
    } catch (e) {
      ref.read(loginPhoneErrorTextProvider.state).state = '登录失败，请稍后再试。';
      ref.read(loginInProgressProvider.state).state = false;
    }
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
