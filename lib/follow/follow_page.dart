import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

import 'controller/follow_model.dart';
import 'follow_card.dart';

class FollowPage extends StatelessWidget {
  final List<FollowModel> followList;

  const FollowPage({
    Key? key,
    required this.followList,
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
          Navigator.pushNamed(
            context,
            '/follow_addedit',
            arguments: '',
          );
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var follow in followList) {
      list.add(Container(
        key: ValueKey(follow),
        child: FollowCard(
          follow: follow,
          widgetList: [
            IconButton(
              tooltip: 'Ver lista de pessoas',
              icon: Icon(AppIconData.people),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/following_users',
                  arguments: follow.id,
                );
              },
            ),
            IconButton(
              tooltip: 'Editar este grupo',
              icon: Icon(AppIconData.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/follow_addedit',
                  arguments: follow.id,
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
        title: Text('Ops. Você ainda não tem grupos com pessoas.'),
      ));
    }
    return list;
  }
}
