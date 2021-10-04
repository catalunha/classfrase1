import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

import 'observer_phrase_card.dart';

class ObserverPhrasePage extends StatelessWidget {
  final List<PhraseModel> observerPhraseList;

  const ObserverPhrasePage({
    Key? key,
    required this.observerPhraseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Observando as frases'),
      ),
      body: Column(
        children: [
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

    for (var phrase in observerPhraseList) {
      list.add(Container(
        key: ValueKey(phrase),
        child: ObserverPhraseCard(
          phrase: phrase,
          widgetList: [
            IconButton(
              tooltip: 'Observar esta frase',
              icon: Icon(AppIconData.letter),
              onPressed: () {
                Navigator.pushNamed(context, '/observed_phrase',
                    arguments: phrase.id);
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Ainda não há frase para ser observada.'),
      ));
    }
    return list;
  }
}
