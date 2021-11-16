import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socfony/services/auth_service.dart';
import 'package:socfony/services/state_service.dart';
import 'package:socfony/src/protobuf/google/protobuf/wrappers.pb.dart';
import 'package:socfony/src/protobuf/socfony.pb.dart';
import 'package:socfony/src/protobuf/socfony.pbgrpc.dart';
import 'package:socfony/theme.dart';
import 'package:socfony/widgets/card_wrapper.dart';

import '../grpc.dart';

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
          onPressed: () {},
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
                'socfony',
                style: AppTheme.of(context)
                    .textTheme
                    .textStyle
                    .resolveFrom(context),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Text('更换'),
                onPressed: () {},
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
        dimension: 80,
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
                    size: 80,
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
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('昵称',
                      style: AppTheme.of(context)
                          .textTheme
                          .caption2
                          .resolveFrom(context, secondary: true)),
                  Text(
                    'Socfony',
                    style: AppTheme.of(context)
                        .textTheme
                        .textStyle
                        .resolveFrom(context),
                  ),
                ],
              ),
            ),
            CupertinoButton(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.forward),
              onPressed: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '生日',
              style:
                  AppTheme.of(context).textTheme.textStyle.resolveFrom(context),
            ),
            CupertinoButton(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.zero,
              child: const Text('2020/01/01'),
              onPressed: () {},
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '性别',
              style:
                  AppTheme.of(context).textTheme.textStyle.resolveFrom(context),
            ),
            CupertinoButton(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.zero,
              child: const Text('男'),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _UserProfileBioCard extends StatelessWidget {
  const _UserProfileBioCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                child: const Text('编辑'),
                onPressed: () {},
              ),
            ],
          ),
          Text('测试测试测试', style: AppTheme.of(context).textTheme.textStyle),
        ],
      ),
    );
  }
}
