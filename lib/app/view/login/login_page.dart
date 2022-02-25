import 'package:classfrase/app/data/assets/app_images.dart';
import 'package:classfrase/app/logic/view/login/login_controller.dart';
import 'package:classfrase/app/view/config/app_colors.dart';
import 'package:classfrase/app/view/config/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final LoginController _controller = Get.find();
  LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              color: AppColors.primary,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image.asset(
                    AppImages.login,
                    width: 208,
                    height: 273,
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Bem vindo ao ClassFrase.',
                      style: AppTextStyles.titleRegular,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 30),
                  googleLoginButton(
                    onTap: () => _controller.signInWithGoogle(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  googleLoginButton({onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 320,
        decoration: BoxDecoration(
            color: AppColors.shape,
            borderRadius: BorderRadius.circular(5),
            border: Border.fromBorderSide(BorderSide(color: AppColors.stroke))),
        child: Row(
          children: [
            Expanded(flex: 1, child: Image.asset(AppImages.google)),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  'Entre com sua conta Google',
                  style: AppTextStyles.buttonBoldGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
