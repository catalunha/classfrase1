import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'controller/phrase_model.dart';

class PhraseCard extends StatelessWidget {
  final PhraseModel phrase;
  final List<Widget>? widgetList;
  const PhraseCard({
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
          ListTile(
            tileColor: Colors.black12,
            title: Text(
              phrase.phrase,
              style: AppTextStyles.buttonBoldHeading,
            ),
          ),
          // Wrap(
          //   children: [
          //     IconButton(
          //       tooltip: 'Classificar esta frase',
          //       icon: Icon(AppIconData.letter),
          //       onPressed: () async {
          //         Navigator.pushNamed(context, '/classifying',
          //             arguments: phrase.id);
          //       },
          //     ),
          //     SizedBox(
          //       width: 25,
          //     ),
          //     phrase.observer!.isEmpty
          //         ? Container(
          //             width: 0,
          //           )
          //         : IconButton(
          //             tooltip: 'Frase sendo observada',
          //             icon: Icon(AppIconData.eye),
          //             onPressed: () {},
          //           ),
          //     SizedBox(
          //       width: 25,
          //     ),
          //     IconButton(
          //       tooltip: 'Editar esta frase',
          //       icon: Icon(AppIconData.edit),
          //       onPressed: () async {
          //         Navigator.pushNamed(context, '/phrase_addedit',
          //             arguments: phrase.id);
          //       },
          //     ),
          //   ],
          // ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
