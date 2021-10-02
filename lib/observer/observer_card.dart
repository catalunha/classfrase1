import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    // List<Widget> temp = widgetList ?? [];
    // temp.add(IconButton(
    //   tooltip: 'Copiar ID desta observação.',
    //   icon: Icon(AppIconData.copy),
    //   onPressed: () {
    //         Future<void> _copyToClipboard() async {
    //   await Clipboard.setData(ClipboardData(text: observer.id));
    // }
    //     _copyToClipboard();
    //     final snackBar =
    //         SnackBar(content: Text('Ok. O ID: ${observer.id} foi copiado'));
    //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
    //   },
    // ));

    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ListTile(
            tileColor: Colors.black12,
            title: Text(
              observer.id,
              style: AppTextStyles.buttonBoldHeading,
            ),
            subtitle: Text(
              observer.description,
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
