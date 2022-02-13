import 'package:classfrase/controller/splash/splash_controller.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final SplashController _controller;
  const SplashPage(this._controller, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Splash'),
      ),
    );
  }
}
