import 'package:classfrase/theme/app_images.dart';
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''
Olá,

Este projeto nasceu da necessidade de nossa familia em estudar as classificações morfológicas, sintáticas e semânticas de algumas frases.

E esperamos que te ajude também.

Contudo existem custos com hospedagem do aplicativo, consultores em lingua portuguesa, equipe de programação, designers, etc.

Se você deseja nos ajudar a manter e ampliar este projeto considere contribuir com QUALQUER quantia.

Para o seguinte PIX: ricelly.catalunha@gmail.com

Ou escaneie o QR Code abaixo
      ''',
                style: AppTextStyles.titleRegular,
              ),
            ),
            Image.asset(
              AppImages.qrcode,
              width: 208,
              height: 273,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''
E já sou-lhe grata pelo carinho,

Ricelly Catalunha.
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
