import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_text_styles.dart';
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
            color: Colors.yellow,
            child: Text(
              phrase.phrase,
              textAlign: TextAlign.center,
              style: AppTextStyles.trailingBold,
            ),
          ),
          ObservedPersonTile(
            phrase: phrase,
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
