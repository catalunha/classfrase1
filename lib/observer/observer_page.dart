import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

import 'controller/observer_model.dart';
import 'observer_card.dart';

class ObserverPage extends StatelessWidget {
  final List<ObserverModel> observerList;

  const ObserverPage({
    Key? key,
    required this.observerList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas observações'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var observer in observerList) {
      list.add(Container(
        key: ValueKey(observer),
        child: ObserverCard(
          observer: observer,
          widgetList: [
            IconButton(
              tooltip: 'Ver lista de frases',
              icon: Icon(AppIconData.unArchive),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            IconButton(
              tooltip: 'Editar esta observação',
              icon: Icon(AppIconData.unArchive),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Vc não esta observando nenhuma frase.'),
      ));
    }
    return list;
  }
}
