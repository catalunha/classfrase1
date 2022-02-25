import 'package:classfrase/app/logic/service/auth/auth_bindinng.dart';
import 'package:classfrase/app/logic/view/home/home_binding.dart';
import 'package:classfrase/app/logic/view/login/login_binding.dart';
import 'package:classfrase/app/view/auth/auth_page.dart';
import 'package:classfrase/app/view/home/home_page.dart';
import 'package:classfrase/app/view/login/login_page.dart';
import 'package:get/get.dart';

class Routes {
  static const auth = '/';
  static const login = '/login';
  static const home = '/home';

  static final pageList = [
    GetPage(
      name: Routes.auth,
      binding: AuthBinding(),
      page: () => AuthPage(),
    ),
    GetPage(
      name: Routes.login,
      binding: LoginBinding(),
      page: () => LoginPage(),
    ),
    GetPage(
      name: Routes.home,
      binding: HomeBinding(),
      page: () => HomePage(),
    ),
  ];
}
