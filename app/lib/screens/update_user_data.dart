import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:grpc/grpc.dart' show GrpcError;
import 'package:provider/provider.dart';
import 'package:socfony/services/auth_service.dart';
import 'package:socfony/services/state_service.dart';
import 'package:socfony/src/protobuf/google/protobuf/wrappers.pb.dart';
import 'package:socfony/src/protobuf/socfony.pb.dart';
import 'package:socfony/src/protobuf/socfony.pbgrpc.dart';
import 'package:socfony/theme.dart';
import 'package:socfony/widgets/card_wrapper.dart';

import '../configuration.dart';

class UpdateUserDataScreen extends StatelessWidget {
  final BuildContext context;

  const UpdateUserDataScreen(this.context, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('编辑资料'),
      ),
      child: _Loadding(),
    );
  }

  void go() {
    Navigator.of(context).push(
      CupertinoPageRoute<void>(
        fullscreenDialog: false,
        builder: (context) => this,
      ),
    );
  }
}

class _Loadding extends StatelessWidget {
  const _Loadding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = context.select<AuthService, String>(
      (service) => service.entity!.userId,
    );
    final UserEntity? initialData = context
        .read<StateService>()
        .find<UserEntity>((element) => element.id == id);
    final UserProfileEntity? profile = context
        .read<StateService>()
        .find<UserProfileEntity>((element) => element.id == id);

    if (initialData != null && profile != null) {
      return const _Page();
    }

    return FutureBuilder(
      initialData: initialData,
      future: fetch(context, id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return const _Page();
        }

        return const Center(
          child: CupertinoActivityIndicator(),
        );
      },
    );
  }

  Future<UserEntity?> fetch(BuildContext context, String id) async {
    final callOption = context.read<AuthService>().callOptions;

    try {
      final user = await UserQueryClient(channel)
          .findOne(UserFindOneRequest()..id = id, options: callOption);
      final profile = await UserProfileQueryClient(channel).find(
        StringValue()..value = user.id,
        options: callOption,
      );

      final state = context.read<StateService>();
      state.update<UserEntity>(user, (element) => element.id == user.id);
      state.update<UserProfileEntity>(
          profile, (element) => element.id == profile.id);

      return user;
    } catch (e) {
      showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('获取用户信息失败'),
          content: const Text('请检查网络连接'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }
}

class _Page extends StatelessWidget {
  const _Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const <Widget>[
        _UserAvavarCard(),
        SizedBox(height: 24),
        _UserCard(),
        SizedBox(height: 24),
        _ProfileCard(),
        SizedBox(height: 24),
        _UserProfileBioCard(),
      ],
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = context.read<AuthService>().entity!.userId;
    final String? username = context.select<StateService, String?>(
      (service) =>
          service.find<UserEntity>((element) => element.id == id)?.name,
    );
    if (username == null || username.isEmpty) {
      return CardWrapper(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Text('设置账户名'),
          onPressed: () => onUpdateAccountName(context),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 4),
          child: Text(
            '账号名',
            style:
                AppTheme.of(context).textTheme.subheadline.resolveFrom(context),
          ),
        ),
        CardWrapper(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                username,
                style: AppTheme.of(context)
                    .textTheme
                    .textStyle
                    .resolveFrom(context),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('更换'),
                onPressed: () => onUpdateAccountName(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 4),
          child: Text(
              '账户名是您账户的唯一自定义识别名称，账户名具有唯一的识别性。如果您的账户名存在侵犯他人商标或者著作权等情况，可能会被收回。',
              style: AppTheme.of(context)
                  .textTheme
                  .footnote
                  .resolveFrom(context, secondary: true)),
        ),
      ],
    );
  }

  Future<void> onUpdateAccountName(BuildContext context) async {
    await _UpdateAccountName(context).show();
  }
}

class _UserAvavarCard extends StatelessWidget {
  const _UserAvavarCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = context.read<AuthService>().entity!.userId;
    final String? avatar = context.select<StateService, String?>(
      (service) => service
          .find<UserProfileEntity>((element) => element.id == id)
          ?.avatar,
    );

    return Center(
      child: SizedBox.square(
        dimension: 120,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Container(
            color:
                AppTheme.of(context).cardBackgroundColor.resolveFrom(context),
            child: Stack(
              children: [
                // TODO: 加载头像
                const Center(
                  child: Icon(
                    CupertinoIcons.person_solid,
                    size: 120,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CupertinoPopupSurface(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 6),
                        child: Text(
                          '编辑',
                          style: AppTheme.of(context)
                              .textTheme
                              .caption2
                              .resolveFrom(context),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardWrapper.divider(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 4),
      children: const <Widget>[
        _Nickname(),
        _Birthday(),
        _Gender(),
      ],
    );
  }
}

class _UserProfileBioCard extends StatefulWidget {
  const _UserProfileBioCard({Key? key}) : super(key: key);

  @override
  State<_UserProfileBioCard> createState() => _UserProfileBioCardState();
}

class _UserProfileBioCardState extends State<_UserProfileBioCard> {
  late TextEditingController controller;
  late bool isEditing;

  @override
  void initState() {
    final String id = context.read<AuthService>().entity!.userId;
    final String? bio = context
        .read<StateService>()
        .find<UserProfileEntity>((element) => element.id == id)
        ?.bio;

    controller = TextEditingController(text: bio);
    isEditing = false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String id = context.read<AuthService>().entity!.userId;
    final String? bio = context.select<StateService, String?>(
      (service) =>
          service.find<UserProfileEntity>((element) => element.id == id)?.bio,
    );

    final Widget widget = isEditing
        ? CupertinoTextField(
            decoration: const BoxDecoration(),
            placeholder: '请输入简介内容',
            controller: controller,
            maxLines: 5,
            maxLength: 500,
            autofocus: true,
            keyboardType: TextInputType.multiline,
          )
        : Text(
            bio != null && bio.isNotEmpty ? bio : '暂无简介～',
            style:
                AppTheme.of(context).textTheme.textStyle.resolveFrom(context),
          );

    return CardWrapper(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '个人简介',
                style: AppTheme.of(context)
                    .textTheme
                    .caption2
                    .resolveFrom(context, secondary: true),
              ),
              CupertinoButton(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.zero,
                child: Text(isEditing ? '完成' : '编辑'),
                onPressed: isEditing ? onDone : onEdit,
              ),
            ],
          ),
          widget,
        ],
      ),
    );
  }

  onEdit() => setState(() => isEditing = true);

  onDone() async {
    FocusScope.of(context).unfocus();
    final request = UserProfileUpdateRequest()..bio = controller.text;

    try {
      final profile = await UserProfileMutationClient(channel)
          .update(request, options: context.read<AuthService>().callOptions);

      context.read<StateService>().update<UserProfileEntity>(
            profile,
            (element) => element.id == profile.id,
          );

      setState(() {
        isEditing = false;
      });
    } catch (e) {
      _showAlert(e is GrpcError ? e.message! : e.toString());
    }
  }

  _showAlert(String mesasge) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('提示'),
        content: Text(mesasge),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _UpdateAccountName extends StatelessWidget {
  final BuildContext context;

  _UpdateAccountName(this.context, {Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('账户名'),
      content: CardWrapper(
        child: CupertinoTextField(
          controller: _controller,
          padding: EdgeInsets.zero,
          placeholder: '请输入用户名',
          decoration: const BoxDecoration(
            border: Border(),
          ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(16),
            FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
          ],
          onSubmitted: (_) => _onDone(),
        ),
      ),
      actions: [
        CupertinoDialogAction(
          child: const Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CupertinoDialogAction(
          child: const Text('确定'),
          onPressed: _onDone,
        ),
      ],
    );
  }

  void _onDone() async {
    final String name = _controller.text;
    if (name.isEmpty) {
      _showAlert('账户名不能为空');
      return;
    } else if (name.length < 4) {
      _showAlert('账户名不能少于4个字符');
      return;
    }

    try {
      final user = await UserMutationClient(channel).updateName(
          StringValue()..value = name,
          options: context.read<AuthService>().callOptions);

      context
          .read<StateService>()
          .update<UserEntity>(user, (element) => element.id == user.id);

      Navigator.of(context).pop();
    } catch (e) {
      _showAlert(e is GrpcError ? e.message! : e.toString());
    }
  }

  _showAlert(String mesasge) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('提示'),
        content: Text(mesasge),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> show() async {
    await showCupertinoDialog(
      context: context,
      builder: (context) => this,
      barrierDismissible: false,
    );
  }
}

class _Nickname extends StatelessWidget {
  const _Nickname({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = context.read<AuthService>().entity!.userId;
    final String? name = context.select<StateService, String?>(
      (service) =>
          service.find<UserProfileEntity>((element) => element.id == id)?.name,
    );

    return Row(
      children: [
        Expanded(
          child: name != null && name.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('昵称',
                        style: AppTheme.of(context)
                            .textTheme
                            .caption2
                            .resolveFrom(context, secondary: true)),
                    Text(
                      name,
                      style: AppTheme.of(context)
                          .textTheme
                          .textStyle
                          .resolveFrom(context),
                    ),
                  ],
                )
              : Text(
                  '昵称',
                  style: AppTheme.of(context)
                      .textTheme
                      .textStyle
                      .resolveFrom(context),
                ),
        ),
        CupertinoButton(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.zero,
          child: name != null && name.isNotEmpty
              ? const Icon(CupertinoIcons.forward)
              : const Text('设置'),
          onPressed: () => onChange(context),
        ),
      ],
    );
  }

  onChange(BuildContext context) {
    final String id = context.read<AuthService>().entity!.userId;
    final String? name = context
        .read<StateService>()
        .find<UserProfileEntity>(
          (element) => element.id == id,
        )
        ?.name;
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => ChangeNotifierProvider(
        create: (_) => TextEditingController(text: name ?? ''),
        builder: (BuildContext context, _) => CupertinoAlertDialog(
          title: const Text('昵称'),
          content: CardWrapper(
            child: CupertinoTextField(
              controller: context.read<TextEditingController>(),
              padding: EdgeInsets.zero,
              placeholder: '请输入昵称',
              decoration: const BoxDecoration(
                border: Border(),
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(24),
              ],
              onSubmitted: (_) => _onDone(context),
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () => _onDone(context),
            ),
          ],
        ),
      ),
    );
  }

  _onDone(BuildContext context) async {
    final name = context.read<TextEditingController>().text.trim();

    if (name.isEmpty) {
      _showAlert(context, '昵称不能为空');
      return;
    } else if (name.length < 2) {
      _showAlert(context, '昵称不能少于2个字符');
      return;
    }

    try {
      final request = UserProfileUpdateRequest()..name = name;
      final profile = await UserProfileMutationClient(channel).update(
        request,
        options: context.read<AuthService>().callOptions,
      );

      context.read<StateService>().update<UserProfileEntity>(
          profile, (element) => element.id == profile.id);

      Navigator.of(context).pop();
    } catch (e) {
      _showAlert(context, e is GrpcError ? e.message! : e.toString());
    }
  }

  _showAlert(BuildContext context, String mesasge) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('提示'),
        content: Text(mesasge),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _Birthday extends StatelessWidget {
  const _Birthday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = context.read<AuthService>().entity!.userId;
    final int? birthday = context.select<StateService, int?>(
      (service) => service
          .find<UserProfileEntity>((element) => element.id == id)
          ?.birthday,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '生日',
          style: AppTheme.of(context).textTheme.textStyle.resolveFrom(context),
        ),
        CupertinoButton(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.zero,
          child: Text(formatBirthday(birthday)),
          onPressed: () => onChange(context),
        ),
      ],
    );
  }

  String formatBirthday(int? birthday) {
    if (birthday == null || birthday.toString().length != 8) {
      return '未设置';
    }
    return '${birthday ~/ 10000}年${(birthday % 10000) ~/ 100}月${birthday % 100}日';
  }

  onChange(BuildContext context) {
    final String id = context.read<AuthService>().entity!.userId;
    final int? birthday = context
        .read<StateService>()
        .find<UserProfileEntity>((element) => element.id == id)
        ?.birthday;
    final DateTime? initialDateTime = birthday != null &&
            birthday.toString().length == 8
        ? DateTime(birthday ~/ 10000, (birthday % 10000) ~/ 100, birthday % 100)
        : null;

    DateTime? value = initialDateTime;

    showCupertinoModalPopup(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Row(
          children: [
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Expanded(
              child: Center(child: Text('生日')),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('确定'),
              onPressed: () => onSubmit(context, value),
            ),
          ],
        ),
        message: SizedBox(
          height: MediaQuery.of(context).size.height / 5,
          child: CupertinoDatePicker(
            initialDateTime: initialDateTime,
            maximumDate: DateTime.now(),
            minimumDate: DateTime(1940),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime date) => value = date,
          ),
        ),
      ),
    );
  }

  onSubmit(BuildContext context, DateTime? value) async {
    final int birthday = value is DateTime
        ? value.year * 10000 + value.month * 100 + value.day
        : 0;

    try {
      final request = UserProfileUpdateRequest()..birthday = birthday;
      final profile = await UserProfileMutationClient(channel).update(
        request,
        options: context.read<AuthService>().callOptions,
      );

      context.read<StateService>().update<UserProfileEntity>(
          profile, (element) => element.id == profile.id);
      Navigator.of(context).pop();
    } catch (e) {
      _showAlert(context, e is GrpcError ? e.message! : e.toString());
    }
  }

  _showAlert(BuildContext context, String mesasge) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('提示'),
        content: Text(mesasge),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class _Gender extends StatelessWidget {
  const _Gender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = context.read<AuthService>().entity!.userId;
    final UserProfileEntity_Gender? gender =
        context.select<StateService, UserProfileEntity_Gender?>(
      (service) => service
          .find<UserProfileEntity>((element) => element.id == id)
          ?.gender,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '性别',
          style: AppTheme.of(context).textTheme.textStyle.resolveFrom(context),
        ),
        CupertinoButton(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.zero,
          child: Text(formatGender(gender)),
          onPressed: () => onShowSelect(context),
        ),
      ],
    );
  }

  String formatGender(UserProfileEntity_Gender? gender) {
    switch (gender) {
      case UserProfileEntity_Gender.man:
        return '男';
      case UserProfileEntity_Gender.woman:
        return '女';
      case UserProfileEntity_Gender.unknown:
      default:
        return '设置';
    }
  }

  onShowSelect(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('性别'),
        actions: [
          CupertinoDialogAction(
            child: const Text('男'),
            onPressed: () =>
                onChangeGender(context, UserProfileEntity_Gender.man),
          ),
          CupertinoDialogAction(
            child: const Text('女'),
            onPressed: () =>
                onChangeGender(context, UserProfileEntity_Gender.woman),
          ),
        ],
        cancelButton: CupertinoDialogAction(
          child: const Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  onChangeGender(BuildContext context, UserProfileEntity_Gender gender) async {
    final request = UserProfileUpdateRequest()..gender = gender;
    try {
      final profile = await UserProfileMutationClient(channel).update(
        request,
        options: context.read<AuthService>().callOptions,
      );

      context.read<StateService>().update<UserProfileEntity>(
          profile, (element) => element.id == profile.id);

      Navigator.of(context).pop();
    } catch (e) {
      _showAlert(context, e is GrpcError ? e.message! : e.toString());
    }
  }

  _showAlert(BuildContext context, String mesasge) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('提示'),
        content: Text(mesasge),
        actions: [
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
