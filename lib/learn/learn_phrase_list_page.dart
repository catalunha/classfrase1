import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

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
        title: Text('Frases para aprender'),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     widget.onSetNullSelectedPhraseAndCategory();
        //     Navigator.pop(context);
        //   },
        // ),
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
              tooltip: 'Ver esta frase',
              icon: Icon(AppIconData.letter),
              onPressed: () {
                Navigator.pushNamed(context, '/learn_phrase',
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
        title: Text('Ops. Esta pessoa não frases públicas.'),
      ));
    }
    return list;
  }
}
