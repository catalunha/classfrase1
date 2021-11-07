import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/theme/theme_app.dart';
import 'package:flutter/material.dart';

import 'controller/observer_model.dart';

class ObserverCard extends StatelessWidget {
  final ObserverModel observer;
  final List<Widget>? widgetList;
  const ObserverCard({
    Key? key,
    required this.observer,
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
            // tileColor: ThemeApp.backgroundPhrase,
            title: Text(
              observer.id,
              // style: AppTextStyles.buttonBoldHeading,
            ),
            subtitle: Text(
              observer.description,
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
