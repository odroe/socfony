import 'package:app/configuration.dart';
import 'package:app/framework.dart';
import 'package:app/grpc.dart';
import 'package:app/modules/auth/auth_store.dart';
import 'package:app/modules/setting/setting_screen.dart';
import 'package:app/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class MainMeScreen extends StatefulWidget {
  const MainMeScreen({Key? key}) : super(key: key);

  @override
  _MainMeScrrenState createState() => _MainMeScrrenState();
}

class _MainMeScrrenState extends State<MainMeScreen>
    with AutomaticKeepAliveClientMixin<MainMeScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final String userId = store.select<AuthStore, String>(userIdSelector)!;

    return FutureBuilder(
      initialData: userId,
      future: fetch(userId),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.hasData) {
          return const _MeScreenScaffold();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  String? userIdSelector(AuthStore? store) => store?.userId;

  Future<String?> fetch(String id) async {
    final UserEntity user = await UserQueryClient(channel).findOne(
      UserFindOneRequest()..id = id,
    );
    final UserProfileEntity profile =
        await UserProfileQueryClient(channel).find(
      StringValue()..value = user.id,
    );

    store.write<UserEntity>(user,
        where: (UserEntity element) => element.id == id);
    store.write<UserProfileEntity>(profile,
        where: (UserProfileEntity element) => element.id == profile.id);

    return user.id;
  }

  @override
  bool get wantKeepAlive => true;
}

class _MeScreenScaffold extends StatelessWidget {
  const _MeScreenScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const _Username(),
        actions: [
          IconButton(
            tooltip: '设置',
            icon: const Icon(Icons.settings),
            onPressed: () {
              SettingScreen.show(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: const <Widget>[
          _UserCard(),
          Divider(
            thickness: 10,
            height: 36,
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: const <Widget>[
              Expanded(
                child: _UserBio(),
              ),
              SizedBox(width: 20),
              _UserAvatar(),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    '387',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    '动态',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              const SizedBox(width: 34),
              Column(
                children: [
                  Text(
                    '14',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    '关注',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
              const SizedBox(width: 34),
              Column(
                children: [
                  Text(
                    '109.6K',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    '粉丝',
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.read<AuthStore>()!.userId;
    final String? name = context.store.select<UserEntity, String>(
      (UserEntity? element) => element?.name,
      where: (UserEntity element) => element.id == userId,
    );
    final String? nickname = context.store.select<UserProfileEntity, String>(
      (UserProfileEntity? element) => element?.name,
      where: (UserProfileEntity element) => element.id == userId,
    );

    return Text(
      nickname != null && nickname.isNotEmpty
          ? nickname
          : name != null && name.isNotEmpty
              ? name
              : userId,
    );
  }
}

class _UserBio extends StatelessWidget {
  const _UserBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userId = context.store.read<AuthStore>()!.userId;
    final String? bio = context.store.select<UserProfileEntity, String>(
      (UserProfileEntity? element) => element?.bio,
      where: (UserProfileEntity element) => element.id == userId,
    );

    return Text(
      bio != null && bio.isNotEmpty ? bio : '这个人很懒，什么都没有留下~',
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const UserAvatar(
      size: 84,
    );
  }
}
