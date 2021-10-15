import 'package:classfrase/learn/users_card.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

import 'controller/learn_model.dart';

class LearningUsersPage extends StatelessWidget {
  final LearnModel learn;
  final Map<String, UserRef> learning;
  final Function(String) userDelete;

  const LearningUsersPage({
    Key? key,
    required this.learning,
    required this.userDelete,
    required this.learn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pessoas deste grupo'),
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

            // subtitle: Text('Grupo selecionado'),
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
          Navigator.pushNamed(
            context,
            '/learn_user_add',
            // arguments: '',
          );
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var person in learning.entries) {
      list.add(
        Container(
          key: ValueKey(person),
          child: UsersCard(
            userRef: person.value,
            userDelete: userDelete,
            widgetList: [
              IconButton(
                tooltip: 'Ver frases desta pessoa',
                icon: Icon(AppIconData.list),
                onPressed: () {
                  Navigator.pushNamed(context, '/learn_phrase_list',
                      arguments: person.key);
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