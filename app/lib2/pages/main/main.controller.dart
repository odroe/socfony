import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final counter = 0.obs;

  late PageController pageController;

  @override
  onInit() {
    super.onInit();
    pageController = PageController(initialPage: counter.value);
  }

  @override
  void onClose() {
    super.onClose();
    pageController.dispose();
  }

  void changePage(int page) {
    counter.value = page;
    pageController.jumpToPage(page);
  }
}
