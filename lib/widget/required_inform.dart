import 'package:flutter/material.dart';

class RequiredInForm extends StatelessWidget {
  const RequiredInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text('Campos com '),
      Text(
        ' * ',
        style: TextStyle(color: Colors.red),
      ),
      Text(' tem preenchimento obrigatório.'),
      // SizedBox(
      //   height: 20,
      // ),
    ]));
  }
}
