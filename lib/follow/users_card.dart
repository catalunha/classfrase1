import 'package:classfrase/follow/person_tile.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class UsersCard extends StatelessWidget {
  final UserRef userRef;
  final List<Widget>? widgetList;
  final Function(String) userDelete;

  const UsersCard({
    Key? key,
    required this.userRef,
    this.widgetList,
    required this.userDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PersonTile(
              displayName: userRef.displayName,
              photoURL: userRef.photoURL,
              trailingIconButton: IconButton(
                tooltip: 'Remover este contato deste grupo',
                icon: Icon(AppIconData.delete),
                onPressed: () {
                  userDelete(userRef.id);
                },
              )),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
