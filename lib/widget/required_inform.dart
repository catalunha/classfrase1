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
              Text('Campos com '),
              Text(
                ' * ',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              Text(' tem preenchimento obrigatório.'),
            ],
          ),
          Text(message),
          SizedBox(
            height: sizedBoxHeight,
          ),
        ],
      ),
    );
  }
}
