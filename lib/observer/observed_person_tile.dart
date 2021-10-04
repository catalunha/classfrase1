import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

class ObservedPersonTile extends StatelessWidget {
  final PhraseModel phrase;

  const ObservedPersonTile({Key? key, required this.phrase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: phrase.userFK.photoURL == null
          ? Icon(AppIconData.undefined)
          : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                phrase.userFK.photoURL!,
                height: 58,
                width: 58,
              ),
            ),
      // tileColor: Colors.black12,
      title: Text(
        phrase.userFK.displayName ?? 'Pessoa sem nome.',
        // style: AppTextStyles.buttonBoldHeading,
      ),
      // subtitle: Text(
      //   phrase.phrase,
      // ),
    );
  }
}
