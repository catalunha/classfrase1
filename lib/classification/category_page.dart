import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

import 'classification_card.dart';
import 'controller/classification_model.dart';

class CategoryPage extends StatelessWidget {
  final Map<String, ClassCategory> category;
  final ClassGroup groupCurrent;
  const CategoryPage({
    Key? key,
    required this.category,
    required this.groupCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias deste grupo - ${category.length}'),
      ),
      body: Column(
        children: [
          ClassificationCard(
            id: groupCurrent.id!,
            title: groupCurrent.title,
            url: groupCurrent.url,
            color: Colors.yellowAccent,
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
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/category_addedit',
            arguments: '',
          );
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];
    // Map<String, ClassCategory> categorySorted = SplayTreeMap.from(category,
    //     (key1, key2) => category[key1]!.title.compareTo(category[key2]!.title));

    for (var item in category.entries) {
      // if (item.value.group == groupCurrent.id) {
      print('${item.value.id} | ${item.value.title}');
      list.add(
        ClassificationCard(
          id: item.value.id!,
          title: item.value.title,
          url: item.value.url,
          widgetList: [
            IconButton(
              tooltip: 'Editar esta categoria',
              icon: Icon(AppIconData.edit),
              onPressed: () => Navigator.pushNamed(
                context,
                '/category_addedit',
                arguments: item.value.id,
              ),
            ),
          ],
        ),
      );
      // }
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Sem categorias neste grupo.'),
      ));
    }
    return list;
  }
}
