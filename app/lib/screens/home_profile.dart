import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socfony/services/auth_service.dart';
import 'package:socfony/services/state_service.dart';
import 'package:socfony/src/protobuf/google/protobuf/wrappers.pb.dart';
import 'package:socfony/src/protobuf/socfony.pb.dart';
import 'package:socfony/src/protobuf/socfony.pbgrpc.dart';
import 'package:socfony/theme.dart';
import 'package:socfony/widgets/card_wrapper.dart';
import 'package:socfony/widgets/not_authenticated.dart';

import '../configuration.dart';
import 'account_security.dart';
import 'update_user_data.dart';

class HomeProfileScreen extends StatelessWidget {
  const HomeProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isAuthenticated =
        context.select<AuthService, bool>((service) => service.isAuthenticated);
    if (!isAuthenticated) {
      return const NotAuthenticated();
    }

    return CupertinoPageScaffold(
      child: ListView(
        children: [
          const _ProfileCard(),
          CardWrapper.divider(
            margin: const EdgeInsets.all(16),
            dividerMargin: const EdgeInsets.symmetric(vertical: 12).copyWith(
              left: 38,
            ),
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.pencil),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '编辑资料',
                        style: AppTheme.of(context)
                            .textTheme
                            .subheadline
                            .resolveFrom(context),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  UpdateUserDataScreen(context).go();
                },
              ),
              GestureDetector(
                  child: Row(
                    children: [
                      const Icon(CupertinoIcons.checkmark_shield),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '账户安全',
                          style: AppTheme.of(context)
                              .textTheme
                              .subheadline
                              .resolveFrom(context),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    AccountSecurityScreen(context).go();
                  }),
            ],
          ),
          CardWrapper.divider(
            margin: const EdgeInsets.all(16),
            dividerMargin: const EdgeInsets.symmetric(vertical: 12).copyWith(
              left: 38,
            ),
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.settings),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '设置',
                      style: AppTheme.of(context)
                          .textTheme
                          .subheadline
                          .resolveFrom(context),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.color_filter),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '外观',
                      style: AppTheme.of(context)
                          .textTheme
                          .subheadline
                          .resolveFrom(context),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.question_circle),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '常见问题',
                      style: AppTheme.of(context)
                          .textTheme
                          .subheadline
                          .resolveFrom(context),
                    ),
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

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = context.select<AuthService, String>(
      (service) => service.entity!.userId,
    );

    return CardWrapper(
      margin: const EdgeInsets.all(12),
      child: FutureBuilder(
        future: _fetch(context, id),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          final UserEntity? user = context.select<StateService, UserEntity?>(
            (service) =>
                service.find<UserEntity>((element) => element.id == id),
          );
          final UserProfileEntity? profile =
              context.select<StateService, UserProfileEntity?>(
            (service) =>
                service.find<UserProfileEntity>((element) => element.id == id),
          );

          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 12),
                child: Icon(CupertinoIcons.profile_circled, size: 64),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: profile?.name.isNotEmpty == true
                                ? profile!.name
                                : '',
                          ),
                          TextSpan(
                            text:
                                '@${user?.name.isNotEmpty == true ? user!.name : user?.id}',
                            style: AppTheme.of(context)
                                .textTheme
                                .caption1
                                .resolveFrom(context, secondary: true),
                          ),
                        ],
                      ),
                      style: AppTheme.of(context)
                          .textTheme
                          .subheadline
                          .resolveFrom(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      profile?.bio.isNotEmpty == true ? profile!.bio : '暂无介绍～',
                      style: AppTheme.of(context)
                          .textTheme
                          .footnote
                          .resolveFrom(context, secondary: true),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(CupertinoIcons.forward),
            ],
          );
        },
      ),
    );
  }

  Future<UserEntity> _fetch(BuildContext context, String id) async {
    final callOptions = context.read<AuthService>().callOptions;
    final user = await UserQueryClient(channel)
        .findOne(UserFindOneRequest()..id = id, options: callOptions);
    final profile = await UserProfileQueryClient(channel)
        .find(StringValue()..value = user.id, options: callOptions);

    // Update state
    final service = context.read<StateService>();
    service.update<UserEntity>(user, (element) => element.id == user.id);
    service.update<UserProfileEntity>(
        profile, (element) => element.id == user.id);

    return user;
  }
}
