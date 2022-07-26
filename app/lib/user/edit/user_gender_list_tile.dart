import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../../auth/auth_provider.dart';
import '../../socfony_service.dart';
import '../user_providers.dart';

/// User gender provider.
final AutoDisposeProvider<User_Gender> _genderProvider =
    Provider.autoDispose<User_Gender>((Ref ref) {
  return ref.watch<User_Gender>(authenticatedUserProvider
      .select((value) => value?.gender ?? User_Gender.unknown));
});

/// Selected gender provider
final AutoDisposeStateProvider<User_Gender> _selectedGenderProvider =
    StateProvider.autoDispose<User_Gender>(
  (Ref ref) => ref.read(_genderProvider),
);

/// Sunmitting provider.
final AutoDisposeStateProvider<bool> _submittingProvider =
    StateProvider.autoDispose<bool>((Ref ref) => false);

/// User gender list tile.
class UserGenderListTile extends StatelessWidget {
  const UserGenderListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('性别'),
      trailing: _GenderButton(),
    );
  }
}

class _GenderButton extends StatelessWidget {
  const _GenderButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => _showGenderDialog(context),
      child: const _GenderText(),
    );
  }

  /// Show gender dialog.
  void _showGenderDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => const _GenderDialog(),
        barrierDismissible: false,
      );
}

class _GenderText extends ConsumerWidget {
  const _GenderText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(gender2text(ref.watch(_genderProvider)));
  }

  /// User gender enum to text.
  static String gender2text(User_Gender gender) {
    switch (gender) {
      case User_Gender.man:
        return '男';
      case User_Gender.woman:
        return '女';
      case User_Gender.unknown:
      default:
        return '隐私';
    }
  }
}

/// Gender dialog
class _GenderDialog extends StatelessWidget {
  const _GenderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('性别'),
      content: _GenderRadioGroup(),
      actions: [
        _CancelDialogButton(),
        _SubmitButton(),
      ],
    );
  }
}

/// Gender raido group.
class _GenderRadioGroup extends StatelessWidget {
  const _GenderRadioGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: ListTile.divideTiles(
        context: context,
        tiles: User_Gender.values.map((e) => _GenderRadioListTile(value: e)),
      ).toList(),
    );
  }
}

/// Gender raido list tile.
class _GenderRadioListTile extends ConsumerWidget {
  const _GenderRadioListTile({Key? key, required this.value}) : super(key: key);

  final User_Gender value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Selected gender
    final User_Gender gender = ref.watch(_selectedGenderProvider);

    Widget? trailing;
    if (gender == value) {
      trailing = Icon(
        Icons.done,
        color: Theme.of(context).colorScheme.primary,
      );
    }

    VoidCallback? onTap;
    if (!ref.watch(_submittingProvider) && gender != value) {
      onTap = () => _updateSelectedGender(ref.read);
    }

    return ListTile(
      title: Text(_GenderText.gender2text(value)),
      trailing: trailing,
      onTap: onTap,
    );
  }

  /// Update selected gender.
  void _updateSelectedGender(Reader reader) {
    reader(_selectedGenderProvider.state).state = value;
  }
}

/// Cancel dialog button
class _CancelDialogButton extends ConsumerWidget {
  const _CancelDialogButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // If submitting, disable the button.
    if (ref.watch(_submittingProvider)) {
      return const SizedBox.shrink();
    }

    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: const Text('取消'),
    );
  }
}

/// Submit button.
class _SubmitButton extends ConsumerStatefulWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  ConsumerState<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<_SubmitButton> {
  @override
  Widget build(BuildContext context) {
    // If submitting, show loading indicator.
    if (ref.watch(_submittingProvider)) {
      return const SizedBox.square(
        dimension: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    VoidCallback? onPressed;
    if (ref.watch(_selectedGenderProvider) != ref.watch(_genderProvider)) {
      onPressed = _onSubmit;
    }

    return TextButton(
      onPressed: onPressed,
      child: const Text('确定'),
    );
  }

  /// Update user gender.
  void _onSubmit() async {
    // Set submitting is true.
    ref.read(_submittingProvider.state).state = true;

    try {
      // Update user gender.
      final User user = await socfonyService.updateUser(
          UpdateUserRequest()..gender = ref.read(_selectedGenderProvider));
      user.save(ref.read);

      if (mounted) Navigator.pop(context);
    } catch (e) {
      final String? errorText = e is GrpcError ? e.message : null;

      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('错误'),
            content: Text(errorText ?? '保存失败'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('确定'),
              ),
            ],
          ),
        );
      }

      // Set submitting is false.
      ref.read(_submittingProvider.state).state = false;
    }
  }
}
