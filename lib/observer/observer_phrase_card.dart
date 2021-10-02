import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/observer_model.dart';

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
            alignment: Alignment.center,
            color: Colors.yellow,
            child: Text(
              phrase.phrase,
              style: AppTextStyles.trailingBold,
            ),
          ),
          ListTile(
            leading: phrase.userRef.photoURL == null
                ? Icon(AppIconData.undefined)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      phrase.userRef.photoURL!,
                      height: 58,
                      width: 58,
                    ),
                  ),
            // tileColor: Colors.black12,
            title: Text(
              phrase.userRef.displayName ?? 'Pessoa sem nome.',
              // style: AppTextStyles.buttonBoldHeading,
            ),
            // subtitle: Text(
            //   phrase.phrase,
            // ),
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
