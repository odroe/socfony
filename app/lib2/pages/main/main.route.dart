import 'package:get/get.dart';

import 'main.building.dart';
import 'main.view.dart';

class MainRoute {
  static String get path => '/';
  static GetPage get route => GetPage(
        name: path,
        page: () => const MainView(),
        binding: MainBinding(),
      );
}
