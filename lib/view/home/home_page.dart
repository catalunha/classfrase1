import 'package:classfrase/logic/auth/auth_controller.dart';
import 'package:classfrase/logic/service/user_controller.dart';
import 'package:classfrase/logic/view/home/home_controller.dart';
import 'package:classfrase/view/home/coffee.dart';
import 'package:classfrase/view/home/information.dart';
import 'package:classfrase/view/theme/app_colors.dart';
import 'package:classfrase/view/theme/app_icon.dart';
import 'package:classfrase/view/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  final HomeController _controller;
  HomePage(this._controller, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        children: [
          // admin(context),
          Center(child: Text('Como deseja usar o ClassFrase ?')),
        ],
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: SafeArea(
        child: Container(
          color: AppColors.primary,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Olá, ${userController.userModel.displayName}',
                style: AppTextStyles.titleRegular,
              ),
              Spacer(),
              popMenu(),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuButton<dynamic> popMenu() {
    return PopupMenuButton(
      child: Tooltip(
        message: 'click here to others options',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          // child: const Icon(Icons.ac_unit),
          child: Image.network(
            '${userController.userModel.photoURL}',
            height: 58,
            width: 58,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Information'),
              onPressed: () async {
                await Get.to(() => const Information());
                Get.back();
              },
              icon: const Icon(AppIconData.info),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Contribuir'),
              onPressed: () async {
                await Get.to(() => const Coffee());
                Get.back();
              },
              icon: const Icon(AppIconData.coffee),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Exit'),
              onPressed: () {
                authController.signOut();
              },
              icon: const Icon(AppIconData.exit),
            ),
          ),
        ];
      },
    );
  }
}
