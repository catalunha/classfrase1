import 'package:classfrase/data/service/auth_service.dart';
import 'package:classfrase/logic/auth/auth_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService());
    Get.lazyPut<AuthController>(() => AuthController(authService: Get.find()));
  }
}
