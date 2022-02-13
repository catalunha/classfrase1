import 'package:classfrase/controller/splash/splash_controller.dart';
import 'package:classfrase/view/splash/splash_page.dart';
import 'package:get/get.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}
