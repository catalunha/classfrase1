import 'package:classfrase/theme/app_colors.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/theme_app.dart';
import 'package:flutter/material.dart';

class InputCheckBoxDelete extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool? value;
  final void Function(bool?) onChanged;

  const InputCheckBoxDelete(
      {Key? key,
      required this.title,
      required this.onChanged,
      this.value,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Text(title, style: TextStyle(color: ThemeApp.onBackground)),
          color: ThemeApp.backgroundLight,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                AppIconData.delete,
                color: ThemeApp.secondary,
              ),
            ),
            Container(
              width: 1,
              height: 48,
              color: ThemeApp.backgroundLight,
            ),
            Expanded(
              child: CheckboxListTile(
                // activeColor: AppColors.delete,
                // selectedTileColor: AppColors.delete,
                selected: value!,
                controlAffinity: ListTileControlAffinity.leading,
                title: value!
                    ? Text(
                        subtitle,
                        // style: TextStyle(color: AppColors.stroke),
                      )
                    : Text(subtitle),
                onChanged: onChanged,
                value: value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
