import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'classification_card.dart';
import 'controller/classification_model.dart';

class GroupPage extends StatelessWidget {
  final List<ClassGroup> group;
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

    print('+++');
    for (var item in group) {
      print('${item.id} | ${item.title}');

      list.add(
        Container(
          key: ValueKey(item),
          child: ClassificationCard(
            id: item.id!,
            title: item.title,
            url: item.url,
            widgetList: [
              IconButton(
                tooltip: 'Editar este grupo',
                icon: Icon(AppIconData.edit),
                onPressed: () => Navigator.pushNamed(
                  context,
                  '/group_addedit',
                  arguments: item.id,
                ),
              ),
              IconButton(
                tooltip: 'Copiar ID desta observação.',
                icon: Icon(AppIconData.copy),
                onPressed: () {
                  Future<void> _copyToClipboard() async {
                    await Clipboard.setData(ClipboardData(text: item.id));
                  }

                  _copyToClipboard();
                  final snackBar = SnackBar(
                      content: Text('Ok. O ID: ${item.id} foi copiado'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
              IconButton(
                tooltip: 'Categorias deste grupo',
                icon: Icon(AppIconData.letter),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/category',
                    arguments: item.id,
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
    print('---');

    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text('Ops. Sem grupos de classificação.'),
      ));
    }
    return list;
  }
}
