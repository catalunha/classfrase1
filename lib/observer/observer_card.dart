import 'package:classfrase/theme/app_text_styles.dart';
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
            tileColor: Colors.black12,
            title: Text(
              observer.descrition,
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
