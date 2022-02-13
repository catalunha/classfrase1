import 'package:classfrase/controller/home/home_binding.dart';
import 'package:classfrase/controller/login/login_binding.dart';
import 'package:classfrase/controller/login/login_controller.dart';
import 'package:classfrase/controller/splash/splash_bindinng.dart';
import 'package:classfrase/controller/splash/splash_controller.dart';
import 'package:classfrase/view/home/home_page.dart';
import 'package:classfrase/view/login/login_page.dart';
import 'package:classfrase/view/splash/splash_page.dart';
import 'package:get/get.dart';

class RoutesPages {
  static final pageList = [
    GetPage(
      name: '/',
      binding: SplashBinding(),
      page: () => SplashPage(Get.find()),
    ),
    GetPage(
      name: '/login',
      binding: LoginBinding(),
      page: () => LoginPage(Get.find()),
    ),
    GetPage(
      name: '/home',
      binding: HomeBinding(),
      page: () => HomePage(Get.find()),
    ),
  ];
}
