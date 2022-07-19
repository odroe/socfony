import 'package:flutter/material.dart';

class HomeTitleTabBar extends StatelessWidget {
  const HomeTitleTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      tabs: const <Tab>[
        Tab(text: '全部'),
        Tab(text: '关注'),
      ],
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Theme.of(context)
          .colorScheme
          .onBackground, // TODO: Bug - https://github.com/flutter/flutter/issues/103642 Need to fix in next release.
      indicatorColor: Theme.of(context).colorScheme.onBackground,
    );
  }
}
