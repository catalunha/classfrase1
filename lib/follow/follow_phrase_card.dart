import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class FollowPhraseCard extends StatelessWidget {
  final PhraseModel phraseModel;
  final List<Widget>? widgetList;
  const FollowPhraseCard({
    Key? key,
    required this.phraseModel,
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
          ListTile(
            tileColor: Colors.black12,
            title: Text(
              phraseModel.phrase,
              style: AppTextStyles.buttonBoldHeading,
            ),
            subtitle: Text(
              phraseModel.font ?? 'Sem fonte.',
            ),
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
