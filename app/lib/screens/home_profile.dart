import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:socfony/services/auth_service.dart';
import 'package:socfony/theme.dart';
import 'package:socfony/widgets/card_wrapper.dart';
import 'package:socfony/widgets/not_authenticated.dart';

class HomeProfile extends StatelessWidget {
  const HomeProfile({Key? key}) : super(key: key);

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
              Row(
                children: [
                  const Icon(CupertinoIcons.pencil),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '资料更新',
                      style: AppTheme.of(context)
                          .textTheme
                          .subheadline
                          .resolveFrom(context),
                    ),
                  ),
                  const Icon(CupertinoIcons.forward),
                ],
              ),
              Row(
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
                  const Icon(CupertinoIcons.forward),
                ],
              ),
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
                  const Icon(CupertinoIcons.forward),
                ],
              ),
              Row(
                children: [
                  const Icon(CupertinoIcons.color_filter),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '主题',
                      style: AppTheme.of(context)
                          .textTheme
                          .subheadline
                          .resolveFrom(context),
                    ),
                  ),
                  Text(
                    '跟随系统',
                    style: AppTheme.of(context)
                        .textTheme
                        .caption1
                        .resolveFrom(context, secondary: true),
                  ),
                  const Icon(CupertinoIcons.forward),
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
                  const Icon(CupertinoIcons.forward),
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
    final userId = context.select<AuthService, String>((service) => service.entity!.userId);

    return CardWrapper(
      margin: const EdgeInsets.all(16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(CupertinoIcons.profile_circled, size: 48),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seven的代码太渣',
                    style: AppTheme.of(context)
                        .textTheme
                        .subheadline
                        .resolveFrom(context)),
                Text(
                  '暂无介绍～',
                  style: AppTheme.of(context)
                      .textTheme
                      .caption2
                      .resolveFrom(context, secondary: true),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // const Text('Profile'),
              ],
            ),
          ),
          const Icon(CupertinoIcons.forward),
        ],
      ),
    );
  }
}
