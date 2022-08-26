import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socfony/socfony_service.dart';
import 'package:socfony/user/user_avatar.dart';
import 'package:socfony/user/user_providers.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../../auth/auth_provider.dart';
import '../../configure.dart';
import '../../minio.dart';
import 'account_id_card.dart';
import 'user_bio_list_tile.dart';
import 'user_birthday_list_tile.dart';
import 'user_gender_list_tile.dart';

class UserEditScreen extends StatelessWidget {
  const UserEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('账户信息'),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          const _UserAvatarEditCard(),
          const SizedBox(height: 24),
          const AccountIdCard(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0).copyWith(top: 24),
            child: Text('资料', style: Theme.of(context).textTheme.bodySmall),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
            child: Column(
              children: ListTile.divideTiles(
                context: context,
                tiles: const <Widget>[
                  UserGenderListTile(),
                  UserBirthdayListTile(),
                  UserBioListTile(),
                ],
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserAvatarEditCard extends StatelessWidget {
  const _UserAvatarEditCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: 92,
        child: Stack(
          fit: StackFit.expand,
          children: const [
            _Avatar(),
            Positioned(
              bottom: 0,
              right: 0,
              child: _ChangeAvatarButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class _Avatar extends ConsumerWidget {
  const _Avatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Current user id provider.
    final provider = authenticatedUserProvider.select((state) => state?.id);
    final String? userId = ref.watch(provider);

    return UserAvatar(id: userId);
  }
}

class _ChangeAvatarButton extends ConsumerWidget {
  const _ChangeAvatarButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => pickImageAndUpload(ref.read, context),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          border: Border.all(
            color: Theme.of(context).colorScheme.background,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Icon(
          Icons.edit,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 16,
        ),
      ),
    );
  }

  ImagePicker get picker => ImagePicker();

  /// Pick image and upload.
  Future<void> pickImageAndUpload(Reader reader, BuildContext context) async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 9999,
      maxHeight: 9999,
    );
    if (file == null) return;

    // Show loading indicator.
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Center(child: Text('正在上传头像')),
        content: SizedBox.square(
          dimension: 48,
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
    );

    // Upload image.
    final String filename = file.name.replaceAll('image_picker_', '');
    final Stream<Uint8List> steram = file.openRead();
    await minio.putObject(sf$cosBucket, filename, steram);

    // Set user avatar.
    final User user =
        await socfonyService.updateUserAvatar(StringValue()..value = filename);
    user.save(reader);

    // Hide loading indicator.
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
