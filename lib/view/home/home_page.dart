import 'package:classfrase/controller/home/home_controller.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller;
  const HomePage(this._controller, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
    );
  }
}
