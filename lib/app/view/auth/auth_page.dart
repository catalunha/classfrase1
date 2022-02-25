import 'package:classfrase/app/logic/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPage extends StatelessWidget {
  final AuthService _authService = Get.find();
  AuthPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              if (_authService.loggedInGoogle.value != true) {
                return const Text('Bem vindo.');
              } else {
                return Column(
                  children: const [
                    Text('Buscando dados de sua conta...'),
                    CircularProgressIndicator(),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
