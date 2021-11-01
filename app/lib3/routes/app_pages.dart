import 'package:get/route_manager.dart';
import 'package:socfony/screens/home.dart';
import 'package:socfony/screens/login.dart';
import 'package:socfony/screens/verification_code.dart';

import 'app_routes.dart';

abstract class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: AppRoutes.verificationCode,
        page: () => const VerificationCodeScreen()),
  ];
}
