import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'controller/follow_model.dart';

class FollowCard extends StatelessWidget {
  final FollowModel follow;
  final List<Widget>? widgetList;
  const FollowCard({
    Key? key,
    required this.follow,
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
              follow.description,
              style: AppTextStyles.buttonBoldHeading,
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
