import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '''
Olá,

Este projeto nasceu da necessidade de nossa familia em estudar as classificações morfológicas, sintáticas e semânticas de algumas frases.

E esperamos que te ajude também.

Com carinho,

Ricelly Catalunha.
      ''',
            style: AppTextStyles.titleRegular,
          ),
        ),
      ),
    );
  }
}
