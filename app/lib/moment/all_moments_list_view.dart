import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';

class AllMomentsListView extends StatelessWidget {
  const AllMomentsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [_MomentCard()],
    );
  }
}

class _MomentCard extends StatelessWidget {
  const _MomentCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          _MomentCardUserTile(),
          _MomentCardTitle(),
          _MomentCardContent(),
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

class _MomentCardContent extends StatelessWidget {
  const _MomentCardContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
        bottom: 8,
      ),
      child: Text(
        'Socfony 的第一条动态！哈哈哈❤️！',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _MomentCardTitle extends StatelessWidget {
  const _MomentCardTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
        bottom: 8,
      ),
      child: Text(
        '🎉 你好，Socfony！',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}

class _MomentCardUserTile extends StatelessWidget {
  const _MomentCardUserTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      horizontalTitleGap: 16,
      dense: true,
      leading: const CircleAvatar(
        backgroundImage: NetworkImage(
          'https://avatars.githubusercontent.com/u/5564821',
        ),
      ),
      title: Text(
        'Seven的代码太渣',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text('3分钟之前', style: Theme.of(context).textTheme.labelSmall),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.favorite_border),
      ),
    );
  }
}
