import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '''
Olá,

Este aplicativo nasceu da necessidade de nossa família em estudar as classificações gramaticais de algumas frases.

É gratuito, com certas cotas para amplo uso.

Contudo frases de cunho imoral ou similares terão seus usuários banidos do aplicativo.

Esperamos te ajudar em seus estudos.

Com carinho,

Família Catalunha.
      ''',
                // style: AppTextStyles.titleRegular,
              ),
            ),
            ListTile(
              title: Text(
                  'Para um rápido tutorial de como utilizar o ClassFrase versão 1.3, clique aqui.'),
              leading: Icon(AppIconData.undefined),
              onTap: () async {
                bool can = await canLaunch(
                    'https://docs.google.com/document/d/1hLI_kF8YdTcV7MBMx_ra6C8szDgNJLf82WUOfd_6RDw/edit?usp=sharing');
                if (can) {
                  await launch(
                      'https://docs.google.com/document/d/1hLI_kF8YdTcV7MBMx_ra6C8szDgNJLf82WUOfd_6RDw/edit?usp=sharing');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
