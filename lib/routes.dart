import 'package:classfrase/logic/auth/auth_bindinng.dart';
import 'package:classfrase/logic/view/home/home_binding.dart';
import 'package:classfrase/logic/view/login/login_binding.dart';
import 'package:classfrase/view/home/home_page.dart';
import 'package:classfrase/view/login/login_page.dart';
import 'package:classfrase/view/splash/splash_page.dart';
import 'package:get/get.dart';

class Routes {
  static const splash = '/';
  static const login = '/login';
  static const home = '/home';

  static final pageList = [
    GetPage(
      name: Routes.splash,
      binding: AuthBinding(),
      page: () => SplashPage(Get.find()),
    ),
    GetPage(
      name: Routes.login,
      binding: LoginBinding(),
      page: () => LoginPage(Get.find()),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeBinding(),
      page: () => HomePage(Get.find()),
    ),
  ];
}
