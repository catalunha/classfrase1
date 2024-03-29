import 'package:classfrase/theme/app_colors.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

class InputEmptyBox extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget widget;

  const InputEmptyBox(
      {Key? key,
      required this.title,
      this.icon = AppIconData.check,
      required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Text(title),
          color: Colors.black12,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),
            Container(
              width: 1,
              height: 48,
              color: AppColors.stroke,
            ),
            Expanded(
              child: widget,
            ),
          ],
        ),
      ],
    );
  }
}
