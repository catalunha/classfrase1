import 'package:classfrase/learn/person_tile.dart';
import 'package:classfrase/theme/theme_app.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class UsersCard extends StatelessWidget {
  final UserRef userRef;
  final List<Widget>? widgetList;

  const UsersCard({
    Key? key,
    required this.userRef,
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
          PersonTile(
            displayName: userRef.displayName,
            photoURL: userRef.photoURL,
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
