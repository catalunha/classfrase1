import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'observed_person_tile.dart';

class ObserverPhraseCard extends StatelessWidget {
  final PhraseModel phrase;
  final List<Widget>? widgetList;
  const ObserverPhraseCard({
    Key? key,
    required this.phrase,
    this.widgetList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: ThemeApp.backgroundPhrase,
            child: Text(
              phrase.phrase,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          ObservedPersonTile(
            phrase: phrase,
          ),
          Container(
            height: 1,
            color: ThemeApp.backgroundText,
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
