import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeTitleTabBar extends StatelessWidget {
  const HomeTitleTabBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      tabs: [
        Tab(text: '全部'),
        Tab(text: '关注'),
      ],
      isScrollable: true,
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Colors
          .black, // TODO: Bug - https://github.com/flutter/flutter/issues/103642 Need to fix in next release.
    );
  }
}
