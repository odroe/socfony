import 'package:flutter/material.dart';

import '../moment/all_moments/all_moments_list_view.dart';

class HomeBodyTabBarView extends StatelessWidget {
  const HomeBodyTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarView(
      physics: NeverScrollableScrollPhysics(), // disable scroll
      children: [
        AllMomentsListView(),
        Center(child: Text('关注')),
      ],
    );
  }
}
