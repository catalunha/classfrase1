import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/theme/theme_app.dart';
import 'package:flutter/material.dart';

import 'controller/learn_model.dart';

class LearnCard extends StatelessWidget {
  final LearnModel learn;
  final List<Widget>? widgetList;
  const LearnCard({
    Key? key,
    required this.learn,
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
            // tileColor: Colors.black12,
            title: Text(
              learn.description,
              // style: AppTextStyles.buttonBoldHeading,
            ),
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
