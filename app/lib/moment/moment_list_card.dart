import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfony/user/user_avatar.dart';
import 'package:socfonyapis/socfonyapis.dart';
import 'package:timelines/timelines.dart';

import '../user/user_when.dart';
import 'moment_providers.dart';

class MomentListCard extends StatelessWidget {
  const MomentListCard({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _MomentCardUserTile(momentId: id),
          _MomentCardTitle(momentId: id),
          _MomentCardContent(momentId: id),
          _MomentMedia(),
          _MomentCommentTimeline(),
        ],
      ),
    );
  }
}

class _MomentCommentTimeline extends StatelessWidget {
  const _MomentCommentTimeline();

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor =
        Theme.of(context).colorScheme.primaryContainer;
    final Color onBackgroundColor =
        Theme.of(context).colorScheme.onPrimaryContainer;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Timeline(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          /// first, the moment comments count
          // TimelineTile(
          //   node: TimelineNode(
          //     indicator: OutlinedDotIndicator(
          //       size: 24,
          //       color: backgroundColor,
          //       borderWidth: 4,
          //     ),
          //     endConnector: SolidLineConnector(color: backgroundColor),
          //   ),
          //   contents: TextButton(
          //     onPressed: () {
          //       // TODO: open comment page
          //     },
          //     child: const Text('共有0条评论'),
          //   ),
          //   nodeAlign: TimelineNodeAlign.start,
          // ),

          /// Comment
          // TimelineTile(
          //   node: TimelineNode(
          //     indicator: DotIndicator(
          //       size: 24,
          //       color: backgroundColor,
          //       child: CircleAvatar(
          //         backgroundColor: backgroundColor,
          //         backgroundImage: const NetworkImage(
          //           'https://avatars.githubusercontent.com/u/5564821',
          //         ),
          //         foregroundColor: onBackgroundColor,
          //       ),
          //     ),
          //     startConnector: SolidLineConnector(color: backgroundColor),
          //     endConnector: SolidLineConnector(color: backgroundColor),
          //   ),
          //   contents: Card(
          //     elevation: 0,
          //     child: ListTile(),
          //   ),
          //   nodeAlign: TimelineNodeAlign.start,
          // ),
          // TimelineTile(
          //   node: TimelineNode(
          //     indicator: DotIndicator(
          //       size: 24,
          //       color: backgroundColor,
          //       child: CircleAvatar(
          //         backgroundColor: backgroundColor,
          //         backgroundImage: const NetworkImage(
          //           'https://avatars.githubusercontent.com/u/5564821',
          //         ),
          //         foregroundColor: onBackgroundColor,
          //       ),
          //     ),
          //     startConnector: SolidLineConnector(color: backgroundColor),
          //     endConnector: SolidLineConnector(color: backgroundColor),
          //   ),
          //   contents: Card(
          //     elevation: 0,
          //     child: ListTile(),
          //   ),
          //   nodeAlign: TimelineNodeAlign.start,
          // ),

          /// Last, quick comment button
          TimelineTile(
            node: TimelineNode(
              indicator: DotIndicator(
                size: 24,
                color: backgroundColor,
                child: CircleAvatar(
                  backgroundColor: backgroundColor,
                  backgroundImage: const NetworkImage(
                    'https://avatars.githubusercontent.com/u/5564821',
                  ),
                  foregroundColor: onBackgroundColor,
                ),
              ),
              // startConnector: SolidLineConnector(color: backgroundColor),
            ),
            contents: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: implement
                },
                icon: const Icon(Icons.comment),
                label: const Text('喜欢就评论一下吧'),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                ),
              ),
            ),
            nodeAlign: TimelineNodeAlign.start,
          ),
        ],
      ),
    );
  }
}

class _MomentMedia extends StatelessWidget {
  const _MomentMedia();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            'https://avatars.githubusercontent.com/u/5564821?v=4',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _MomentCardContent extends ConsumerWidget {
  const _MomentCardContent({
    Key? key,
    required this.momentId,
  }) : super(key: key);

  final String momentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        createMomentProvider(momentId).select((state) => state?.content);
    final String? content = ref.watch(provider);
    if (content == null || content.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
        bottom: 8,
      ),
      child: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _MomentCardTitle extends ConsumerWidget {
  const _MomentCardTitle({
    Key? key,
    required this.momentId,
  }) : super(key: key);

  final String momentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        createMomentProvider(momentId).select((state) => state?.title);
    final String? title = ref.watch(provider);

    if (title == null || title.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
        bottom: 8,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class _MomentCardUserTile extends ConsumerWidget {
  const _MomentCardUserTile({
    Key? key,
    required this.momentId,
  }) : super(key: key);

  final String momentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider =
        createMomentProvider(momentId).select((value) => value?.userId);
    final String? userId = ref.watch(provider);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      horizontalTitleGap: 16,
      dense: true,
      leading: UserAvatar(id: userId),
      title: _Username(id: userId),
      subtitle: _Timeago(momentId: momentId),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border),
      ),
    );
  }
}

class _Timeago extends ConsumerWidget {
  const _Timeago({
    Key? key,
    required this.momentId,
  }) : super(key: key);

  final String momentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AlwaysAliveProviderListenable<Timestamp?> provider =
        createMomentProvider(momentId).select((value) => value?.createdAt);
    final DateTime? createdAt = ref.watch(provider)?.toDateTime();

    if (createdAt == null) {
      return const SizedBox.shrink();
    }

    final now = DateTime.now();
    final diff = DateTime.now().difference(createdAt);
    if (diff.inDays > 0) {
      if (now.year == createdAt.year) {
        return Text(
          MaterialLocalizations.of(context).formatMediumDate(createdAt),
          style: Theme.of(context).textTheme.labelSmall,
        );
      }
      return Text(
        MaterialLocalizations.of(context).formatShortDate(createdAt),
        style: Theme.of(context).textTheme.labelSmall,
      );
    } else if (diff.inHours >= 1) {
      return Text(
        '${diff.inHours}小时之前',
        style: Theme.of(context).textTheme.labelSmall,
      );
    } else if (diff.inMinutes >= 1) {
      return Text(
        '${diff.inMinutes}分钟之前',
        style: Theme.of(context).textTheme.labelSmall,
      );
    }

    return Text(
      '${diff.inSeconds}秒之前',
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String? id;

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      return const SizedBox.shrink();
    }

    return UserWhen(
      id: id!,
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return Text(
            snapshot.data?.name ?? id!,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
