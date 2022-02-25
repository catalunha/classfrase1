import 'package:classfrase/app/logic/service/auth/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final AuthService _authService;
  HomeController({required AuthService authService})
      : _authService = authService;
  get userModel => _authService.userModel;
  get user => _authService.userFirebase;
  // User? user() {
  //   return _authService.userFirebase;
  // }

  // UserModel userModel() {
  //   return _authService.userModel;
  // }

  void signOut() async {
    _authService.signOut();
  }
}
