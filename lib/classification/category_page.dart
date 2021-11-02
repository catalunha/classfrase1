import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

import 'classification_card.dart';
import 'controller/classification_model.dart';

class CategoryPage extends StatelessWidget {
  final List<ClassCategory> category;
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
            // color: Colors.yellowAccent,
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

    print('+++ ${groupCurrent.title} +++');
    for (var item in category) {
      print('${item.title} | ${item.id}');
      list.add(
        ClassificationCard(
          id: item.id!,
          title: item.title,
          url: item.url,
          widgetList: [
            IconButton(
              tooltip: 'Editar esta categoria',
              icon: Icon(AppIconData.edit),
              onPressed: () => Navigator.pushNamed(
                context,
                '/category_addedit',
                arguments: item.id,
              ),
            ),
          ],
        ),
      );
    }
    print('---');

    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Sem categorias neste grupo.'),
      ));
    }
    return list;
  }
}
