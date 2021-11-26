import 'package:app/modules/auth/auth_store.dart';
import 'package:app/widgets/svg_icon.dart';
import 'package:app/framework.dart';
import 'package:flutter/material.dart';

import 'main_me_screen.dart';
import 'main_moments_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PageController controller;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    PageController? controller = store.read<PageController>();
    if (controller == null) {
      controller = PageController(initialPage: currentPage);
      store.state.items.add(controller);
    }

    this.controller = controller;
    this.controller.addListener(listener);
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    super.dispose();
  }

  void listener() {
    setState(() {
      currentPage = controller.page!.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _PageView(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
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
        onTap: onJumpToPage,
      ),
    );
  }

  void onJumpToPage(int page) async {
    if ([2, 3].contains(page)) {
      return await AuthStore.can<void>(
        context,
        next: (_) => controller.jumpToPage(page),
      );
    }

    controller.jumpToPage(page);
  }
}

class _PageView extends StatelessWidget {
  const _PageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController? controller = context.store.read<PageController>();

    return PageView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      children: const <Widget>[
        MainMomentsScreen(),
        Text('消息'),
        Text('消息'),
        MainMeScreen(),
      ],
    );
  }
}
