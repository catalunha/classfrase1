import 'package:classfrase/follow/person_tile.dart';
import 'package:classfrase/theme/app_text_styles.dart';
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
            userRef: userRef,
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
