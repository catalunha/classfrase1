import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:classfrase/widget/app_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'learn_phrase_card.dart';
import 'person_tile.dart';

class LearnPhraseListPage extends StatelessWidget {
  final List<PhraseModel> phraseList;
  final UserRef userRefCurrent;

  const LearnPhraseListPage({
    Key? key,
    required this.phraseList,
    required this.userRefCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classificações para aprender'),
      ),
      body: Column(
        children: [
          PersonTile(
            displayName: userRefCurrent.displayName,
            photoURL: userRefCurrent.photoURL,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var phrase in phraseList) {
      list.add(Container(
        key: ValueKey(phrase),
        child: LearnPhraseCard(
          phraseModel: phrase,
          widgetList: [
            IconButton(
              tooltip: 'Ver classificação desta frase.',
              icon: Icon(AppIconData.letter),
              onPressed: () {
                Navigator.pushNamed(context, '/learn_phrase',
                    arguments: phrase.id);
              },
            ),
            // SizedBox(
            //   width: 50,
            // ),
            IconButton(
              tooltip: 'Imprimir a classificação desta frase.',
              onPressed: () => Navigator.pushNamed(
                context,
                '/pdf_learn',
                arguments: phrase.id,
              ),
              icon: Icon(Icons.print),
            ),
            AppLink(
              url: phrase.diagramUrl,
              icon: AppIconData.diagram,
              tooltipMsg: 'Ver diagrama desta frase',
            ),
            IconButton(
              tooltip: 'Copiar a frase para área de transferência.',
              icon: Icon(AppIconData.copy),
              onPressed: () {
                Future<void> _copyToClipboard() async {
                  await Clipboard.setData(ClipboardData(text: phrase.phrase));
                }

                _copyToClipboard();
                final snackBar =
                    SnackBar(content: Text('Ok. A frase foi copiada.'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Esta pessoa não frases públicas.'),
      ));
    }
    return list;
  }
}
