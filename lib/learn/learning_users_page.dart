import 'package:classfrase/learn/users_card.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

import 'controller/learn_model.dart';
import 'controller/learn_user_add_page_connector.dart';

class LearningUsersPage extends StatelessWidget {
  final LearnModel learn;
  final List<UserRef> learningList;
  final Function(String) onUserDelete;
  final Function(String) onSetUserGetPhrases;

  const LearningUsersPage({
    Key? key,
    required this.learn,
    required this.onUserDelete,
    required this.learningList,
    required this.onSetUserGetPhrases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoas do grupo'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: Colors.black12,
            child: Text(
              learn.description,
              style: AppTextStyles.buttonBoldHeading,
            ),
          ),
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
        tooltip: 'Adicionar uma pessoa.',
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => LearnUserAddPageConnector());
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var person in learningList) {
      list.add(
        Container(
          key: ValueKey(person),
          child: UsersCard(
            userRef: person,
            widgetList: [
              IconButton(
                tooltip: 'Ver frases desta pessoa.',
                icon: Icon(AppIconData.list),
                onPressed: () {
                  onSetUserGetPhrases(person.id);
                  Navigator.pushNamed(context, '/learn_phrase_list',
                      arguments: person.id);
                },
              ),
              SizedBox(
                width: 50,
              ),
              IconButton(
                tooltip: 'Filtrar frases desta pessoa.',
                icon: Icon(AppIconData.search),
                onPressed: () {
                  onSetUserGetPhrases(person.id);
                  Navigator.pushNamed(context, '/learn_phrase_filter',
                      arguments: person.id);
                },
              ),
              SizedBox(
                width: 50,
              ),
              IconButton(
                tooltip: 'Remover esta pessoa do grupo.',
                icon: Icon(AppIconData.delete),
                onPressed: () {
                  onUserDelete(person.id);
                },
              ),
            ],
          ),
        ),
      );
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Ainda não há pessoas em sua lista.'),
      ));
    }
    return list;
  }
}
