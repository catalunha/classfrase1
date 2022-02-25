import 'package:classfrase/app/logic/service/auth/auth_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final AuthService _authService;
  LoginController({required AuthService authService})
      : _authService = authService;

  signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }
}
