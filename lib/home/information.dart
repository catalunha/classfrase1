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

Este aplicativo nasceu da necessidade de nossa familia em estudar as classificações morfológicas, sintáticas e semânticas de algumas frases.

Este aplicativo é gratuito e de livre uso. Contudo frases de cunho imoral ou similares terão seus usuários banidos do aplicativo.

Esperamos te ajudar em seus estudos.

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
