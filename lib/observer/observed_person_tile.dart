import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

class ObservedPersonTile extends StatelessWidget {
  final PhraseModel phrase;

  const ObservedPersonTile({Key? key, required this.phrase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      title: Text(
        phrase.userRef.displayName ?? 'Pessoa sem nome.',
      ),
    );
  }
}
