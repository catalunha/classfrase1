import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class Coffee extends StatelessWidget {
  const Coffee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orientações'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '''
Olá,

Este projeto nasceu da necessidade de nossa familia em estudar as classificações morfológicas, sintáticas e semânticas de algumas frases.

E esperamos que te ajude também.

Contudo existem custos com hospedagem do aplicativo, consultores em lingua portuguesa, equipe de programação, designers, etc.

Se você deseja nos ajudar a manter e ampliar este projeto considere contribuir com uma quantia para o seguinte PIX: xxxxx


E já sou-lhe grata pelo carinho,

Ricelly Catalunha.
      ''',
            style: AppTextStyles.titleRegular,
          ),
        ),
      ),
    );
  }
}
