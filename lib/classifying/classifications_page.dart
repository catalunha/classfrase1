import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/app_link.dart';
import 'package:flutter/material.dart';
import 'dart:collection';

class ClassificationsPage extends StatelessWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final String groupId;
  final ClassGroup groupData;
  final Map<String, ClassCategory> category;
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
    required this.category,
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
                  children: buildPhrase(context),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.black12,
            child: Text('clique para escolher uma ou mais opções'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...buildCategories(context),
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

  List<InlineSpan> buildPhrase(context) {
    List<InlineSpan> list = [];
    for (var wordPos = 0; wordPos < phraseList.length; wordPos++) {
      if (phraseList[wordPos] != ' ') {
        list.add(TextSpan(
          text: phraseList[wordPos],
          style: selectedPhrasePosList.contains(wordPos)
              ? TextStyle(color: Colors.red)
              : null,
        ));
      } else {
        list.add(TextSpan(
          text: phraseList[wordPos],
        ));
      }
    }

    return list;
  }

  List<Widget> buildCategories(context) {
    List<Widget> list = [];
    Map<String, ClassCategory> sorted = SplayTreeMap.from(category,
        (key1, key2) => category[key1]!.title.compareTo(category[key2]!.title));
    for (var item in sorted.entries) {
      list.add(Row(
        children: [
          Expanded(
            child: Container(
              color: selectedCategoryIdList.contains(item.key)
                  ? Colors.yellow
                  : null,
              child: ListTile(
                title: Text('${item.value.title}'),
                // subtitle: Text('${item.key}'),
                onTap: () {
                  //print('${item.key}');
                  onSelectCategory(item.key);
                },
              ),
            ),
          ),
          AppLink(
            url: item.value.url,
          ),
        ],
      ));
    }
    return list;
  }
}
