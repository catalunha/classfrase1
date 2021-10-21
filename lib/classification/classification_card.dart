import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/widget/app_link.dart';
import 'package:flutter/material.dart';

class ClassificationCard extends StatelessWidget {
  final String id;
  final String title;
  final String? url;
  final List<Widget>? widgetList;
  final Color color;

  const ClassificationCard({
    Key? key,
    required this.title,
    required this.id,
    required this.url,
    this.widgetList,
    this.color = Colors.black12,
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
            tileColor: color,
            title: Text(
              title,
              style: AppTextStyles.trailingBold,
            ),
            subtitle: Text(
              id,
            ),
            trailing: AppLink(url: url),
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
