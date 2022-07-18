import 'package:flutter/material.dart';

import 'home_body_tab_bar_view.dart';
import 'home_notifications_button.dart';
import 'home_search_button.dart';
import 'home_title_tab_bar.dart';
import 'home_user_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const HomeTitleTabBar(),
          actions: const [
            HomeSearchButton(),
            HomeNotificationsButton(),
            HomeUserButton(),
          ],
        ),
        body: const HomeBodyTabBarView(),
      ),
    );
  }
}

// final _homePageController = ChangeNotifierProvider.autoDispose(
//   (Ref ref) => PageController(
//     initialPage: 0,
//     keepPage: true,
//     viewportFraction: 1,
//   ),
// );

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       bottomNavigationBar: _NavigationBar(),
//       body: _PageView(),
//     );
//   }
// }

// class _NavigationBar extends ConsumerWidget {
//   const _NavigationBar();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return NavigationBar(
//       selectedIndex: _resolveSelectedIndex(ref),
//       onDestinationSelected: _createOnDestinationSelectedCallback(ref),
//       destinations: [
//         NavigationDestination(
//           icon: SvgPicture.asset(
//             'assets/socfony.svg',
//             width: 24,
//             height: 24,
//           ),
//           label: '动态',
//         ),
//         const NavigationDestination(
//           icon: Icon(Icons.favorite_outline),
//           selectedIcon: Icon(Icons.favorite),
//           label: '关注',
//         ),
//         const _PublishMomentButton(),
//         const NavigationDestination(
//           icon: Icon(Icons.chat_bubble_outline),
//           selectedIcon: Icon(Icons.chat_bubble),
//           label: '消息',
//         ),
//         const NavigationDestination(
//           icon: Icon(Icons.person_outline),
//           selectedIcon: Icon(Icons.person),
//           label: '我的',
//         ),
//       ],
//     );
//   }

//   /// Resolve selected index in [PageController].
//   int _resolveSelectedIndex(WidgetRef ref) {
//     final PageController controller = ref.watch(_homePageController);
//     final int index = controller.page?.toInt() ?? controller.initialPage;

//     return index < 2 ? index : (index + controller.viewportFraction).toInt();
//   }

//   /// Create callback for [NavigationBar] to handle destination selection.
//   void Function(int) _createOnDestinationSelectedCallback(WidgetRef ref) {
//     return (int index) {
//       final PageController controller = ref.read(_homePageController);
//       controller.jumpToPage(
//           index < 2 ? index : (index - controller.viewportFraction).toInt());
//     };
//   }
// }

// class _PublishMomentButton extends StatelessWidget {
//   const _PublishMomentButton();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: FloatingActionButton(
//         onPressed: () {},
//         mini: true,
//         heroTag: null,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class _PageView extends ConsumerWidget {
//   const _PageView();

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return PageView(
//       controller: ref.watch(_homePageController),
//       physics: const NeverScrollableScrollPhysics(),
//       children: const [
//         AllMomentsScreen(),
//         Text('2'),
//         Text('3'),
//         Text('4'),
//       ],
//     );
//   }
// }
