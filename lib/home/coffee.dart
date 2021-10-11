import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class Coffee extends StatelessWidget {
  const Coffee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Se desejar pode contribuir'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''
Olá,

Este projeto nasceu da necessidade de nossa família em estudar as classificações gramaticais de algumas frases.

Muitas pessoas tem nos ajudado, e temos recebido muitas sugestões de aperfeiçoamento. Somos muito gratos a todos.

Se você deseja nos ajudar a manter (pois temos custos com hospedagem do aplicativo, Métricas de Armazenamento/Acessos, Serviços em tempo real, etc) e ampliar (buscando consultores, programadores, designers, etc) este projeto considere contribuir com QUALQUER quantia para este PIX de CPF: 91302315315

E já sou-lhe grata pelo carinho,

Família Catalunha.
      ''',
                style: AppTextStyles.titleRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
