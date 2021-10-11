import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';
import 'classification_card.dart';
import 'controller/classification_model.dart';

class GroupPage extends StatelessWidget {
  final Map<String, ClassGroup> group; // uuid:group

  const GroupPage({
    Key? key,
    required this.group,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grupos de classificação - ${group.length}'),
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
            '/group_addedit',
            arguments: '',
          );
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];
    // Map<String, ClassGroup> groupSorted = SplayTreeMap.from(group,
    //     (key1, key2) => group[key1]!.title.compareTo(group[key2]!.title));
    for (var item in group.entries) {
      print('${item.value.id} | ${item.value.title}');

      list.add(
        Container(
          key: ValueKey(item.value),
          child: ClassificationCard(
            id: item.value.id!,
            title: item.value.title,
            url: item.value.url,
            widgetList: [
              IconButton(
                tooltip: 'Editar este grupo',
                icon: Icon(AppIconData.edit),
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/group_addedit',
                  arguments: item.value.id,
                ),
              ),
              IconButton(
                tooltip: 'Categorias deste grupo',
                icon: Icon(AppIconData.letter),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/category',
                    arguments: item.value.id,
                  );
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
        title: Text('Ops. Sem grupos de classificação.'),
      ));
    }
    return list;
  }
}
