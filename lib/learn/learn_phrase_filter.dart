import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/theme_app.dart';
import 'package:classfrase/widget/app_link.dart';
import 'package:flutter/material.dart';

class LearnPhraseFilter extends StatelessWidget {
  final List<ClassGroup> groupList;
  final String? groupId;

  final Function(String) onSetGroup;
  final List<ClassCategory> categoryList;
  final List<PhraseModel> phraseList;
  final Function(String) onFilterByThisCategory;

  const LearnPhraseFilter({
    Key? key,
    required this.groupList,
    required this.onSetGroup,
    required this.categoryList,
    this.groupId,
    required this.phraseList,
    required this.onFilterByThisCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha o filtro'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            // color: Colors.black12,
            child: Center(
              child: Text('Clique num grupo para mostrar suas classificações.'),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: buildGroup(context),
            ),
          ),
          groupId == null
              ? Container()
              : Container(
                  // color: Colors.black12,
                  child: Text('Clique na classificação desejada.'),
                ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (groupId == '720c16e8-f119-44b8-82dd-80ade6e2feae')
                    ...buildCategoriesListNotExpanded(context),
                  if (groupId != '720c16e8-f119-44b8-82dd-80ade6e2feae')
                    ...buildCategoriesListExpanded(context),
                  SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildGroup(context) {
    List<Widget> list = [];

    for (var group in groupList) {
      list.add(
        TextButton(
          onPressed: () {
            onSetGroup(group.id!);
          },
          child: Text('${group.title}'),
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }
    return list;
  }

  List<Widget> buildCategoriesListNotExpanded(context) {
    List<Widget> list = [];
    List<Widget> listExpansion = [];
    String setCategory = '';

    for (var category in categoryList) {
      if (category.title.split(' - ').length == 1) {
        if (list.isNotEmpty) {
          listExpansion.add(
            ExpansionTile(
              // backgroundColor: Colors.black12,
              title: Text(
                setCategory,
                style: TextStyle(fontSize: 24),
              ),
              children: list,
            ),
          );
          setCategory = '';
          list = [];
        }
        setCategory = category.title;
      }
      bool containThisCategory = false;
      for (var phrase in phraseList) {
        if (phrase.allCategoryList!.contains(category.id)) {
          containThisCategory = true;
          break;
        }
      }
      list.add(
        Row(
          children: [
            Expanded(
              child: Container(
                color: containThisCategory ? ThemeApp.backgroundLight : null,
                child: ListTile(
                  title: Text('${category.title}'),
                  onTap: containThisCategory
                      ? () {
                          onFilterByThisCategory(category.id!);
                          Navigator.pushNamed(context, '/learn_phrase_list',
                              arguments: '');
                        }
                      : null,
                ),
              ),
            ),
            AppLink(
              url: category.url,
            ),
          ],
        ),
      );
    }
    if (list.isNotEmpty) {
      listExpansion.add(
        ExpansionTile(
          // backgroundColor: Colors.black12,
          title: Text(
            setCategory,
            style: TextStyle(fontSize: 24),
          ),
          children: list,
        ),
      );
      setCategory = '';
      list = [];
    }
    return listExpansion;
  }

  List<Widget> buildCategoriesListExpanded(context) {
    List<Widget> list = [];
    for (var category in categoryList) {
      bool containThisCategory = false;
      for (var phrase in phraseList) {
        if (phrase.allCategoryList!.contains(category.id)) {
          containThisCategory = true;
          break;
        }
      }
      list.add(
        Row(
          children: [
            Expanded(
              child: Container(
                color: containThisCategory ? ThemeApp.backgroundLight : null,
                child: ListTile(
                  title: Text('${category.title}'),
                  onTap: containThisCategory
                      ? () {
                          onFilterByThisCategory(category.id!);
                          Navigator.pushNamed(context, '/learn_phrase_list',
                              arguments: '');
                        }
                      : null,
                ),
              ),
            ),
            AppLink(
              url: category.url,
            ),
          ],
        ),
      );
    }
    return list;
  }
}
