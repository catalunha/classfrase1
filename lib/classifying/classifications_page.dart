import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/app_link.dart';
import 'package:flutter/material.dart';

import 'controller/classification_type.dart';

class ClassificationsPage extends StatelessWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final String groupId;
  final ClassGroup groupData;
  final List<ClassCategory> categoryList;
  final Function(String) onSelectCategory;
  final List<String> selectedCategoryIdList;
  final VoidCallback onSaveClassification;
  final VoidCallback onSetNullSelectedCategoryIdOld;

  const ClassificationsPage({
    Key? key,
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.groupId,
    required this.groupData,
    required this.categoryList,
    required this.onSelectCategory,
    required this.selectedCategoryIdList,
    required this.onSaveClassification,
    required this.onSetNullSelectedCategoryIdOld,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            onSetNullSelectedCategoryIdOld();
            Navigator.pop(context);
          },
        ),
        title: Text('Opções para ${groupData.title}'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 28, color: Colors.black),
                  children: buildPhraseNoSelectable(
                    context: context,
                    phraseList: phraseList,
                    selectedPhrasePosList: selectedPhrasePosList,
                  ),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Text('clique para escolher uma ou mais opções.'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (groupData.id == '720c16e8-f119-44b8-82dd-80ade6e2feae')
                    ...buildCategoriesListNotExpanded(context),
                  if (groupData.id != '720c16e8-f119-44b8-82dd-80ade6e2feae')
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
      floatingActionButton: FloatingActionButton(
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          onSaveClassification();
        },
      ),
    );
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
              backgroundColor: Colors.black12,
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
      list.add(
        Row(
          children: [
            Expanded(
              child: Container(
                color: selectedCategoryIdList.contains(category.id)
                    ? Colors.yellow
                    : null,
                child: ListTile(
                  title: Text('${category.title}'),
                  onTap: () {
                    onSelectCategory(category.id!);
                  },
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
          backgroundColor: Colors.black12,
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
      list.add(
        Row(
          children: [
            Expanded(
              child: Container(
                color: selectedCategoryIdList.contains(category.id)
                    ? Colors.yellow
                    : null,
                child: ListTile(
                  title: Text('${category.title}'),
                  onTap: () {
                    onSelectCategory(category.id!);
                  },
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
