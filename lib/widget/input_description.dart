import 'package:classfrase/theme/app_colors.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/theme/theme_app.dart';
import 'package:flutter/material.dart';

class InputDescription extends StatelessWidget {
  final String label;
  final bool required;

  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String) onChanged;
  const InputDescription({
    Key? key,
    required this.label,
    this.icon = AppIconData.description,
    this.initialValue,
    this.validator,
    this.controller,
    required this.onChanged,
    this.required = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(label),
              required
                  ? Text(
                      ' *',
                      // style: TextStyle(color: Colors.red),
                    )
                  : Container(),
            ]),
            color: ThemeApp.backgroundText,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  icon,
                  color: ThemeApp.icon01Color,
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: ThemeApp.backgroundText,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  controller: controller,
                  initialValue: initialValue,
                  validator: validator,
                  onChanged: onChanged,
                  // style: AppTextStyles.input,
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  decoration: InputDecoration(
                    // labelStyle: AppTextStyles.input,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          // TextFormField(
          //   controller: controller,
          //   initialValue: initialValue,
          //   validator: validator,
          //   onChanged: onChanged,
          //   // style: AppTextStyles.input,
          //   keyboardType: TextInputType.multiline,
          //   maxLines: 5,
          //   decoration: InputDecoration(
          //     label// style: AppTextStyles.input,
          //     icon: Row(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 8),
          //           child: Icon(
          //             icon,
          //             // color: AppColors.primary,
          //           ),
          //         ),
          //         Container(
          //           width: 1,
          //           height: 48,
          //           // color: AppColors.stroke,
          //         ),
          //       ],
          //     ),
          //     border: InputBorder.none,
          //   ),
          // ),
        ],
      ),
    );
  }
}
