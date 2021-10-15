import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'controller/observer_addedit_page_controller.dart';
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
        title: Text('Meus IDs de observador'),
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
        tooltip: 'Adicionar uma observação.',
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          // Navigator.pushNamed(
          //   context,
          //   '/observer_addedit',
          //   arguments: '',
          // );
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  ObserverAddEditPageConnector(addOrEditId: ''));
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
              tooltip: 'Ver lista de pessoas e frases com este ID',
              icon: Icon(AppIconData.people),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/observer_phrase',
                  arguments: observer.id,
                );
              },
            ),
            IconButton(
              tooltip:
                  'Copiar ID para ser adicionado em uma frase para que eu a observe.',
              icon: Icon(AppIconData.copy),
              onPressed: () {
                Future<void> _copyToClipboard() async {
                  await Clipboard.setData(ClipboardData(text: observer.id));
                }

                _copyToClipboard();
                final snackBar = SnackBar(
                    content: Text('Ok. O ID: ${observer.id} foi copiado'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
            IconButton(
              tooltip: 'Editar o título deste ID de observador',
              icon: Icon(AppIconData.edit),
              onPressed: () {
                // Navigator.pushNamed(
                //   context,
                //   '/observer_addedit',
                //   arguments: observer.id,
                // );
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        ObserverAddEditPageConnector(addOrEditId: observer.id));
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
