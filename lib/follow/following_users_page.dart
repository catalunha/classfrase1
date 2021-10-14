import 'package:classfrase/follow/users_card.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/theme/app_text_styles.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

import 'controller/follow_model.dart';

class FollowingUsersPage extends StatelessWidget {
  final FollowModel follow;
  final Map<String, UserRef> following;
  final Function(String) userDelete;

  const FollowingUsersPage({
    Key? key,
    required this.following,
    required this.userDelete,
    required this.follow,
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
              follow.description,
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
            '/follow_user_add',
            // arguments: '',
          );
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var person in following.entries) {
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
                  Navigator.pushNamed(context, '/follow_phrase_list',
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
