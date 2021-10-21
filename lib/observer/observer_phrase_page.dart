import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

import 'observer_phrase_card.dart';

class ObserverPhrasePage extends StatelessWidget {
  final List<PhraseModel> observerPhraseList;
  final Function(String) setNullObserverFieldPhrase;

  const ObserverPhrasePage({
    Key? key,
    required this.observerPhraseList,
    required this.setNullObserverFieldPhrase,
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
              tooltip: 'Ver classificação desta frase em tempo real.',
              icon: Icon(AppIconData.letter),
              onPressed: () {
                Navigator.pushNamed(context, '/observed_phrase',
                    arguments: phrase.id);
              },
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
              tooltip: 'Remover esta frase de minhas observações.',
              icon: Icon(AppIconData.delete),
              onPressed: () {
                setNullObserverFieldPhrase(phrase.id);
              },
            ),
            SizedBox(
              width: 50,
            ),
            IconButton(
              tooltip: 'Imprimir a classificação desta frase.',
              onPressed: () => Navigator.pushNamed(
                context,
                '/pdf_observer',
                arguments: phrase.id,
              ),
              icon: Icon(Icons.print),
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
