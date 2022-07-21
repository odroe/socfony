import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_in_progress_provider.dart';

/// Login agrements status provider.
final AutoDisposeStateProvider<bool> loginAgrementsStatusProvider =
    StateProvider.autoDispose<bool>((Ref ref) => false);

/// Login agrements widget.
class LoginAgrementsWidget extends StatelessWidget {
  const LoginAgrementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: const [
          _AgrementsStatusCheckbox(),
          Expanded(child: _AgrementsTextRich()),
        ],
      ),
    );
  }
}

/// agrements status checkbox.
class _AgrementsStatusCheckbox extends ConsumerWidget {
  const _AgrementsStatusCheckbox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Create a checkbox value change callback.
    ValueChanged<bool?>? onChanged;

    // If login in progress status is false, create a checkbox value change callback.
    if (!ref.watch(loginInProgressProvider)) {
      onChanged = (bool? value) => _onChanged(ref, value);
    }

    return Checkbox(
      value: ref.watch<bool>(loginAgrementsStatusProvider),
      onChanged: onChanged,
    );
  }

  void _onChanged(WidgetRef ref, bool? value) => ref
      .read(loginAgrementsStatusProvider.notifier)
      .update((state) => value ?? false);
}

/// agrements text rich.
class _AgrementsTextRich extends StatelessWidget {
  const _AgrementsTextRich({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    // User agrements recognizer.
    final TapGestureRecognizer userAgrementsRecognizer = TapGestureRecognizer()
      ..onTap = _onUserAgrementsTap;

    // Privacy policy recognizer.
    final TapGestureRecognizer privacyPolicyRecognizer = TapGestureRecognizer()
      ..onTap = _onPrivacyPolicyTap;

    // Theme data
    final ThemeData themeData = Theme.of(context);

    // Text style
    final TextStyle? textStyle = themeData.textTheme.bodyMedium;

    // Link text style
    final TextStyle? linkTextStyle =
        themeData.textTheme.bodyMedium?.copyWith(color: themeData.primaryColor);

    return Text.rich(
      TextSpan(
        text: '我已阅读并同意',
        style: textStyle,
        children: [
          TextSpan(
            text: '《用户协议》',
            recognizer: userAgrementsRecognizer,
            style: linkTextStyle,
          ),
          const TextSpan(text: '和'),
          TextSpan(
            text: '《隐私政策》',
            recognizer: privacyPolicyRecognizer,
            style: linkTextStyle,
          ),
        ],
      ),
    );
  }

  /// User agrements tap.
  void _onUserAgrementsTap() {
    // TODO: implement jump to user agrements page.
  }

  /// Privacy policy tap.
  void _onPrivacyPolicyTap() {
    // TODO: implement jump to privacy policy page.
  }
}
