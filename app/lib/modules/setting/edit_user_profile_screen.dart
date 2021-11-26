import 'package:app/configuration.dart';
import 'package:app/framework.dart';
import 'package:app/grpc.dart' hide ConnectionState;
import 'package:app/modules/auth/auth_store.dart';
import 'package:app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class EditUserProfileScreen extends StatelessWidget {
  static Future<void> show(BuildContext context) async {
    AuthStore.can(
      context,
      show: true,
      next: (_) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const EditUserProfileScreen(),
          fullscreenDialog: false,
        ),
      ),
    );
  }

  const EditUserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.select<AuthStore, String>(
      (store) => store?.userId,
    )!;

    return FutureBuilder(
      future: fetch(context, userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return const _EditUserProfileScreenScaffold();
      },
    );
  }

  Future<UserProfileEntity?> fetch(BuildContext context, String userId) async {
    final UserProfileEntity profile = await UserProfileQueryClient(channel)
        .find(StringValue()..value = userId,
            options: context.store.read<AuthStore>()?.callOptions);

    context.store.write<UserProfileEntity>(profile,
        where: (element) => element.id == userId);

    return profile;
  }
}

class _EditUserProfileScreenScaffold extends StatelessWidget {
  const _EditUserProfileScreenScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('个人资料'),
      ),
      body: ListView(
        children: const <Widget>[
          SizedBox(height: 24),
          _UpdateUserAvatarCard(),
          SizedBox(height: 24),
          Divider(thickness: 12),
          _UserNickname(),
          _UserGender(),
          ListTile(
            title: Text('生日'),
            subtitle: Text('2020-01-01'),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(thickness: 12),
          ListTile(
            title: Text('简介'),
            trailing: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}

class _UpdateUserAvatarCard extends StatelessWidget {
  const _UpdateUserAvatarCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double size = 84;

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: <Widget>[
            const UserAvatar(size: size),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: size / 3,
                height: size / 3,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(size / 4),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.onPrimary,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.camera_alt,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: size / 6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserNickname extends StatelessWidget {
  const _UserNickname({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.read<AuthStore>()!.userId;
    final String? name = context.store.select<UserProfileEntity, String>(
      (element) => element?.name,
      where: (element) => element.id == userId,
    );

    return ListTile(
      title: const Text('昵称'),
      subtitle: name != null && name.isNotEmpty ? Text(name) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: () => updateNicknameDialog(context, name),
    );
  }

  void updateNicknameDialog(BuildContext context, String? name) {
    _UpdateUserNicknameDialog.show(context, name);
  }
}

class _UpdateUserNicknameDialog extends StatefulWidget {
  static void show(BuildContext context, String? name) {
    showDialog(
        context: context,
        builder: (_) => _UpdateUserNicknameDialog(name),
        barrierDismissible: false);
  }

  const _UpdateUserNicknameDialog(this.initialValue, {Key? key})
      : super(key: key);

  final String? initialValue;

  @override
  State<_UpdateUserNicknameDialog> createState() =>
      _UpdateUserNicknameDialogState();
}

class _UpdateUserNicknameDialogState extends State<_UpdateUserNicknameDialog> {
  late final TextEditingController controller;
  String? value;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('修改昵称'),
      content: TextField(
        enabled: !isSubmitting,
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(
          hintText: '请输入昵称',
        ),
        maxLength: 20,
      ),
      actions: isSubmitting
          ? <Widget>[
              TextButton.icon(
                icon: const SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                  width: 18,
                  height: 18,
                ),
                label: const Text('修改中...'),
                onPressed: null,
              ),
            ]
          : <Widget>[
              TextButton(
                child: const Text('取消'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ElevatedButton(
                child: const Text('确定'),
                onPressed: onSubmit,
              ),
            ],
    );
  }

  void onSubmit() async {
    if (widget.initialValue == controller.text) {
      Navigator.of(context).pop();
      return;
    } else if (controller.text.isEmpty) {
      showAlert('昵称不能为空');
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    final String nickname = controller.text;
    final UserProfileUpdateRequest request = UserProfileUpdateRequest()
      ..name = nickname.trim();

    try {
      final UserProfileEntity response =
          await UserProfileMutationClient(channel)
              .update(request, options: store.read<AuthStore>()?.callOptions);

      store.write<UserProfileEntity>(
        response,
        where: (element) => element.id == response.id,
      );

      Navigator.of(context).pop();
    } catch (e) {
      showAlert(e.toString());
    }
  }

  showAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _UserGender extends StatelessWidget {
  const _UserGender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.read<AuthStore>()!.userId;
    final UserProfileEntity_Gender? gender =
        context.store.select<UserProfileEntity, UserProfileEntity_Gender>(
      (element) => element?.gender,
      where: (element) => element.id == userId,
    );

    return ListTile(
      title: const Text('性别'),
      subtitle: Text(gender2str(gender)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => showGenderSelector(context),
    );
  }

  String gender2str(UserProfileEntity_Gender? gender) {
    switch (gender) {
      case UserProfileEntity_Gender.man:
        return '男';
      case UserProfileEntity_Gender.woman:
        return '女';
      case UserProfileEntity_Gender.unknown:
      default:
        return '未设置';
    }
  }

  void showGenderSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () => Navigator.of(context).pop(),
        builder: (context) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('性别'),
                const SizedBox(height: 8),
                TextButton(
                  child: const Text('男'),
                  onPressed: () =>
                      update(context, UserProfileEntity_Gender.man),
                ),
                TextButton(
                  child: const Text('女'),
                  onPressed: () =>
                      update(context, UserProfileEntity_Gender.woman),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void update(BuildContext context, UserProfileEntity_Gender gender) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext conetxt) => AlertDialog(
        title: const Text('性别'),
        content: TextButton.icon(
          icon: const SizedBox(
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
            width: 18,
            height: 18,
          ),
          label: const Text('修改中...'),
          onPressed: null,
        ),
      ),
    );

    try {
      final UserProfileUpdateRequest request = UserProfileUpdateRequest()
        ..gender = gender;
      final UserProfileEntity response =
          await UserProfileMutationClient(channel).update(request,
              options: context.store.read<AuthStore>()?.callOptions);

      context.store.write<UserProfileEntity>(
        response,
        where: (element) => element.id == response.id,
      );

      Navigator.of(context).pop();
    } catch (e) {
      showAlert(context, e.toString());
      Navigator.of(context).pop();
    } finally {
      Navigator.of(context).pop();
    }
  }

  void showAlert(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
