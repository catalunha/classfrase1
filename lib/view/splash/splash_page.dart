import 'package:classfrase/logic/auth/auth_controller.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final AuthController _controller;
  const SplashPage(this._controller, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Bem vindo. Estou atualizando algumas informações...'),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
