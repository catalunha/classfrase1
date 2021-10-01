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
      floatingActionButton: FloatingActionButton(
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/observer_addedit',
            arguments: '',
          );
        },
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
              icon: Icon(AppIconData.eye),
              onPressed: () {
                // Navigator.pop(context);
              },
            ),
            IconButton(
              tooltip: 'Editar esta observação',
              icon: Icon(AppIconData.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/observer_addedit',
                  arguments: observer.id,
                );
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
