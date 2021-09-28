import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class Orientations extends StatelessWidget {
  const Orientations({Key? key}) : super(key: key);

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
      
      Esta aplicativo é gratuito e de livre uso. 
      
      Contudo frases de cunho imoral ou similares terão seus usuários banidos do aplicativo.
      
      Atenciosamente,
      
      Ricelly Catalunha.
            ''',
            style: AppTextStyles.titleRegular,
          ),
        ),
      ),
    );
  }
}
