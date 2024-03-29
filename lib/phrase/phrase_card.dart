import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'controller/phrase_model.dart';

class PhraseCard extends StatelessWidget {
  final PhraseModel phrase;
  final List<Widget>? widgetList;
  final Widget? trailing;
  const PhraseCard({
    Key? key,
    required this.phrase,
    this.widgetList,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ListTile(
            tileColor: Colors.yellowAccent,
            title: Text(
              phrase.phrase,
              style: AppTextStyles.trailingBold,
            ),
            trailing: trailing,
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
