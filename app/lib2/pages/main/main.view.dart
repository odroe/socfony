import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main.controller.dart';

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (RxInt counter) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 24.0,
          currentIndex: counter.value,
          onTap: (index) => controller.changePage(index),
          showUnselectedLabels: false,
          showSelectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: const CircleAvatar(
                radius: 12.0,
                backgroundImage: AssetImage('assets/logo.png'),
              ),
              label: '动态',
              backgroundColor: Get.theme.primaryColor,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              label: '发现',
              backgroundColor: Colors.green,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined),
              activeIcon: Icon(Icons.message),
              label: '消息',
              backgroundColor: Colors.orange,
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              activeIcon: Icon(Icons.account_circle),
              label: '我的',
              backgroundColor: Colors.blue,
            ),
          ],
        ),
        body: PageView(
          controller: controller.pageController,
          onPageChanged: (index) => controller.changePage(index),
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Center(child: Text('动态')),
            Center(child: Text('发现')),
            Center(child: Text('消息')),
            Center(child: Text('我的')),
          ],
        ),
      ),
      controller.counter,
      key: key,
    );
  }
}
