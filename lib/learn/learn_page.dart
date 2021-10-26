import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

import 'controller/learn_addedit_page_connector.dart';
import 'controller/learn_model.dart';
import 'learn_card.dart';

class LearnPage extends StatelessWidget {
  final List<LearnModel> learnList;

  const LearnPage({
    Key? key,
    required this.learnList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus grupos de aprendizado'),
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
        tooltip: 'Adicionar um grupo.',
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) =>
                  LearnAddEditPageConnector(addOrEditId: ''));
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var learn in learnList) {
      list.add(Container(
        key: ValueKey(learn),
        child: LearnCard(
          learn: learn,
          widgetList: [
            IconButton(
              tooltip: 'Ver lista de pessoas deste grupo.',
              icon: Icon(AppIconData.people),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/learning_users',
                  arguments: learn.id,
                );
              },
            ),
            IconButton(
              tooltip: 'Editar este grupo.',
              icon: Icon(AppIconData.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        LearnAddEditPageConnector(addOrEditId: learn.id));
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Você ainda não tem grupos com pessoas.'),
      ));
    }
    return list;
  }
}
