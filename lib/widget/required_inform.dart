import 'package:classfrase/theme/theme_app.dart';
import 'package:flutter/material.dart';

class RequiredInForm extends StatelessWidget {
  final String message;
  final double sizedBoxHeight;
  const RequiredInForm({Key? key, this.message = '', this.sizedBoxHeight = 80})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Campos com ',
                style: TextStyle(
                  color: ThemeApp.onBackgroundLight,
                ),
              ),
              Text(
                ' * ',
                style: TextStyle(
                  color: ThemeApp.error,
                  fontSize: 16,
                ),
              ),
              Text(' tem preenchimento obrigatório.',
                  style: TextStyle(
                    color: ThemeApp.onBackgroundLight,
                  )),
            ],
          ),
          Text(message,
              style: TextStyle(
                color: ThemeApp.onBackgroundLight,
              )),
          SizedBox(
            height: sizedBoxHeight,
          ),
        ],
      ),
    );
  }
}
