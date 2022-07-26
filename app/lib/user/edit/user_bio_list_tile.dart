import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../../auth/auth_provider.dart';
import '../../socfony_service.dart';
import '../user_providers.dart';

/// User bio provider.
final AutoDisposeProvider<String?> _bioProvider =
    Provider.autoDispose<String?>((Ref ref) {
  return ref.watch(authenticatedUserProvider.select((value) => value?.bio));
});

/// User bio editting controller provider.
final AutoDisposeChangeNotifierProvider<TextEditingController>
    _bioEdittingControllerProvider =
    ChangeNotifierProvider.autoDispose<TextEditingController>((Ref ref) {
  // Create the controller.
  return TextEditingController(text: ref.read(_bioProvider));
});

/// Text field error text provider.
final AutoDisposeStateProvider<String?> _textFieldErrorTextProvider =
    StateProvider.autoDispose<String?>((Ref ref) => null);

/// User bio saveing provider.
final AutoDisposeStateProvider<bool> _saveingProvider =
    StateProvider.autoDispose<bool>((Ref ref) => false);

/// User bio list tile.
class UserBioListTile extends StatelessWidget {
  const UserBioListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          const Expanded(child: Text('简介')),
          TextButton(
            onPressed: () => _jumpToEditBioScreen(context),
            child: const Text('编辑'),
          ),
        ],
      ),
      subtitle: const _BioText(),
    );
  }

  // Jump to edit bio screen.
  void _jumpToEditBioScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _EditBioScreen(),
      ),
    );
  }
}

class _BioText extends ConsumerWidget {
  const _BioText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch user bio.
    final String? bio = ref.watch(_bioProvider);

    return Text(bio == null || bio.isEmpty ? '暂无简介' : bio);
  }
}

/// Edit bio screen.
class _EditBioScreen extends StatelessWidget {
  const _EditBioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('编辑简介'),
        actions: const [_SaveButton()],
      ),
      body: ListView(
        children: const [
          SizedBox(height: 24),
          Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _BioTextField(),
            ),
          ),
        ],
      ),
    );
  }
}

class _BioTextField extends ConsumerWidget {
  const _BioTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      autofocus: true,
      controller: ref.watch(_bioEdittingControllerProvider),
      readOnly: ref.watch(_saveingProvider),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.zero,
        ),
        hintText: '请输入简介',
        errorText: ref.watch(_textFieldErrorTextProvider),
      ),
      maxLines: 5,
      maxLength: 300,
      keyboardType: TextInputType.multiline,
    );
  }
}

/// Save button.
class _SaveButton extends ConsumerStatefulWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  ConsumerState<_SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends ConsumerState<_SaveButton> {
  @override
  Widget build(BuildContext context) {
    // If the user is saving, show a loading indicator.
    if (ref.watch(_saveingProvider)) {
      return const IconButton(
        onPressed: null,
        icon: SizedBox.square(
          dimension: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    VoidCallback? onPressed;
    final String? originalBio = ref.watch(_bioProvider);
    final String newBio =
        ref.watch(_bioEdittingControllerProvider.select((value) => value.text));
    if (originalBio != newBio) {
      onPressed = _saveBio;
    }

    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: const Text('保存'),
      ),
    );
  }

  /// Save bio.
  void _saveBio() async {
    // Update saveing state.
    ref.read(_saveingProvider.state).state = true;

    try {
      // Update User bio
      final User user = await socfonyService.updateUser(UpdateUserRequest()
        ..bio = ref.read(_bioEdittingControllerProvider).text);
      user.save(ref.read);

      // Back to the previous screen.
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      final String? errorText = e is GrpcError ? e.message : null;
      ref.read(_textFieldErrorTextProvider.state).state = errorText ?? '保存失败';
      // Update saveing state.
      ref.read(_saveingProvider.state).state = false;
    }
  }
}
