import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../../auth/auth_provider.dart';
import '../../socfony_service.dart';
import '../user_providers.dart';

// Create user name provider.
final AutoDisposeProvider<String?> _usernameProvider =
    Provider.autoDispose((Ref ref) {
  // Create selected user name provider.
  final AlwaysAliveProviderListenable<String?> provider =
      authenticatedUserProvider.select((value) => value?.name);

  return ref.watch(provider);
});

// Has user set user name provider.
final AutoDisposeProvider<bool> _hasUserSetnNameProvider =
    Provider.autoDispose<bool>(
  (Ref ref) {
    return ref.watch<bool>(authenticatedUserProvider.select((User? user) {
      return user != null && user.hasName() && user.name.isNotEmpty;
    }));
  },
);

/// Edit username Editing controller provider.
final _usernameController =
    ChangeNotifierProvider.autoDispose<TextEditingController>(
  (Ref ref) {
    // Read current user name.
    final String? username = ref.read(_usernameProvider);

    // Create editing controller.
    return TextEditingController(text: username);
  },
);

/// Submitting provider.
final AutoDisposeStateProvider<bool> _submittingProvider =
    StateProvider.autoDispose<bool>((Ref ref) => false);

/// Username editing error text provider.
final AutoDisposeStateProvider<String?> _usernameErrorTextProvider =
    StateProvider.autoDispose<String?>((Ref ref) => null);

class AccountIdCard extends StatelessWidget {
  const AccountIdCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: _UserNameText(),
        subtitle: Text('用户名是你账户的唯一标识'),
        trailing: _AutoGeneratedButton(),
      ),
    );
  }
}

class _AutoGeneratedButton extends ConsumerWidget {
  const _AutoGeneratedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      child: Text(ref.watch(_hasUserSetnNameProvider) ? '更改' : '设置'),
      onPressed: () => _showChangeUsernameDialog(context),
    );
  }

  /// Show change user name dialog.
  void _showChangeUsernameDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => const _ChangeUsernameDialog(),
    );
  }
}

class _UserNameText extends ConsumerWidget {
  const _UserNameText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch selected user name provider.
    final String? name = ref.watch(_usernameProvider);

    return Text(name != null && name.isNotEmpty ? name : '用户名');
  }
}

/// Change user name dialog.
class _ChangeUsernameDialog extends StatelessWidget {
  const _ChangeUsernameDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: _AutoGeneratedDialogTitle(),
      content: _EditUsernameTextField(),
      actions: [
        _CancelDialogButton(),
        _SubmitUsernameButton(),
      ],
    );
  }
}

class _SubmitUsernameButton extends ConsumerStatefulWidget {
  const _SubmitUsernameButton({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<_SubmitUsernameButton> createState() =>
      _SubmitUsernameButtonState();
}

class _SubmitUsernameButtonState extends ConsumerState<_SubmitUsernameButton> {
  @override
  Widget build(BuildContext context) {
    // If submitting, show loading indicator.
    if (ref.watch(_submittingProvider)) {
      return const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      );
    }

    return TextButton(
      onPressed: _onSubmit,
      child: const Text('确定'),
    );
  }

  /// submit username.
  void _onSubmit() async {
    // Set submitting.
    ref.read(_submittingProvider.state).state = true;

    // Read username.
    final String username = ref.read(_usernameController).text;

    try {
      // Update username.
      final User user =
          await socfonyService.updateUserName(StringValue()..value = username);
      user.save(ref.read);

      // Navigate back.
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (e is GrpcError) {
        // Set error text.
        ref.read(_usernameErrorTextProvider.state).state = e.message;
      } else {
        ref.read(_usernameErrorTextProvider.state).state = '更改失败，请重试';
      }

      // Set submitting.
      ref.read(_submittingProvider.state).state = false;
    }
  }
}

class _CancelDialogButton extends ConsumerWidget {
  const _CancelDialogButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If submitting, show empty widget.
    if (ref.watch(_submittingProvider)) {
      return const SizedBox.shrink();
    }

    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('取消'),
    );
  }
}

class _EditUsernameTextField extends ConsumerWidget {
  const _EditUsernameTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      enabled: !ref.watch(_submittingProvider),
      controller: ref.watch(_usernameController),
      decoration: InputDecoration(
        hintText: '请输入用户名',
        helperText: '允许输入空格外的任何符号，用户名仅用作个人账户的标识和展示。',
        helperMaxLines: 3,
        errorText: ref.watch(_usernameErrorTextProvider),
      ),
      autofocus: true,
      maxLength: 12,
      inputFormatters: [
        // 不允许输入空白符号.
        FilteringTextInputFormatter.allow(RegExp(r'[^\s]')),
      ],
      keyboardType: TextInputType.name,
    );
  }
}

class _AutoGeneratedDialogTitle extends ConsumerWidget {
  const _AutoGeneratedDialogTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(ref.watch(_hasUserSetnNameProvider) ? '更改用户名' : '设置用户名');
  }
}
