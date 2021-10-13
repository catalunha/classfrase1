import 'package:classfrase/follow/users_card.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class FollowingUsersPage extends StatelessWidget {
  final Map<String, UserRef> following;

  const FollowingUsersPage({
    Key? key,
    required this.following,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seguindo estas pessoas'),
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
            widgetList: [
              IconButton(
                tooltip: 'Ver frases desta pessoa',
                icon: Icon(AppIconData.letter),
                onPressed: () {
                  Navigator.pushNamed(context, '/observed_phrase',
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
