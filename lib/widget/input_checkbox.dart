import 'package:classfrase/theme/app_colors.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_themes.dart';
import 'package:flutter/material.dart';

class InputCheckBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  final bool? value;
  final void Function(bool?) onChanged;

  const InputCheckBox(
      {Key? key,
      required this.title,
      required this.onChanged,
      this.value,
      required this.subtitle,
      this.icon = AppIconData.check})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Text(title),
          color: MyTheme.backgroundTitle,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                icon,
                color: MyTheme.iconAddOrEdit,
              ),
            ),
            Container(
              width: 1,
              height: 48,
              color: MyTheme.backgroundTitle,
            ),
            Expanded(
              child: CheckboxListTile(
                title: Text(subtitle),
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
