import 'package:app/widgets/svg_icon.dart';
import 'package:app/framework.dart';
import 'package:flutter/material.dart';

import 'main_me_screen.dart';
import 'main_moments_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController? controller = context.store.read<PageController>();
    final int currentIndex = context.store.select<PageController, int>(
          (PageController? controller) => controller?.hasClients == true
              ? controller!.page!.round()
              : controller?.initialPage ?? 0,
        )!;

    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          MainMomentsScreen(),
          Text('社区'),
          Text('消息'),
          MainMeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgIcon('assets/bottom_navigation_bar/home.svg',
                type: SvgIconType.asset),
            activeIcon: SvgIcon(
                'assets/bottom_navigation_bar/home_selected.svg',
                type: SvgIconType.asset),
            label: '动态',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon('assets/bottom_navigation_bar/community.svg',
                type: SvgIconType.asset),
            activeIcon: SvgIcon(
                'assets/bottom_navigation_bar/community_selected.svg',
                type: SvgIconType.asset),
            label: '社区',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon('assets/bottom_navigation_bar/message.svg',
                type: SvgIconType.asset),
            activeIcon: SvgIcon(
                'assets/bottom_navigation_bar/message_selected.svg',
                type: SvgIconType.asset),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: SvgIcon('assets/bottom_navigation_bar/me.svg',
                type: SvgIconType.asset),
            activeIcon: SvgIcon('assets/bottom_navigation_bar/me_selected.svg',
                type: SvgIconType.asset),
            label: '我',
          ),
        ],
        onTap: (index) {
          controller?.jumpToPage(index);
          context.store.write(controller);
        },
      ),
    );
  }
}