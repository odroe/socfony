import 'package:app/configuration.dart';
import 'package:app/framework.dart';
import 'package:app/grpc.dart' hide ConnectionState;
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
        if (snapshot.connectionState == ConnectionState.done) {
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

  List<String> get tabs => const <String>['动态', '喜欢', '评论'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const _Username(),
            centerTitle: false,
            expandedHeight: 200,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  SettingScreen.show(context);
                },
              ),
            ],
            bottom: tabBar,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(
                  bottom: tabBar.preferredSize.height,
                  top: MediaQuery.of(context).padding.top + kToolbarHeight,
                  right: 16,
                  left: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: _UserBio(),
                    ),
                    UserAvatar(
                      size: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TabBar get tabBar => TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: tabs.map((String tab) => Tab(text: tab)).toList(),
      );
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
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
    );
  }
}
