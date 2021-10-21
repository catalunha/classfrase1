import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

class PersonTile extends StatelessWidget {
  final String? displayName;
  final String? photoURL;
  final String? email;
  final String? id;
  final String? uid;
  final Widget? trailingIconButton;

  const PersonTile({
    Key? key,
    required this.displayName,
    required this.photoURL,
    this.email,
    this.id,
    this.uid,
    this.trailingIconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: photoURL == null
          ? Icon(AppIconData.undefined)
          : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                photoURL!,
                height: 58,
                width: 58,
              ),
            ),
      title: Text(
        displayName ?? 'Pessoa sem nome.',
      ),
      trailing: trailingIconButton,
    );
  }
}
