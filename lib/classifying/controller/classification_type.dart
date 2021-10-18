import 'dart:collection';

import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum ClassBy { grupo, selecao }

extension ClassByExtension on ClassBy {
  static const names = {
    ClassBy.grupo: 'Classificação por GRUPO.',
    ClassBy.selecao: 'Classificação por SELEÇÃO.',
    // ClassBy.linha: 'Classificação por LINHA.',
  };
  String get name => names[this]!;
}

extension ClassByExtensionIcon on ClassBy {
  static const icons = {
    ClassBy.grupo: Icons.view_array_rounded,
    ClassBy.selecao: Icons.view_headline_rounded,
    // ClassBy.linha: 'Classificação por LINHA.',
  };
  IconData get icon => icons[this]!;
}

List<Widget> buildClassByLine2({
  required BuildContext context,
  required Map<String, ClassGroup> group,
  required Map<String, ClassCategory> category,
  required Map<String, Classification> phraseClassifications,
  required List<String> classOrder,
  required List<String> phraseList,
}) {
  List<Widget> lineList = [];

  Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
      group, (key1, key2) => group[key1]!.title.compareTo(group[key2]!.title));
  // Map<String, Classification> classificationSorted = SplayTreeMap.from(
  //     phraseClassifications,
  //     (key1, key2) => phraseClassifications[key1]!.posPhraseList.join()
  //         .compareTo(
  //             phraseClassifications[key2]!.posPhraseList.length));
  // for (var i = 0; i < phraseList.length; i++) {
  //   for (var classification in phraseClassifications.entries) {
  for (var classId in classOrder) {
    Classification classification = phraseClassifications[classId]!;
    // List<int> phrasePosList = classification.posPhraseList;
    // if (i == phrasePosList[0]) {
    List<InlineSpan> listSpan = [];
    for (var i = 0; i < phraseList.length; i++) {
      listSpan.add(TextSpan(
        text: phraseList[i],
        style: phraseList[i] != ' ' && classification.posPhraseList.contains(i)
            ? TextStyle(
                color: Colors.orange.shade900,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              )
            : null,
      ));
    }
    RichText richText = RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 28, color: Colors.black),
        children: listSpan,
      ),
    );

    List<Widget> categoryWidgetList = [];
    for (var groutItem in groupSorted.entries) {
      List<String> categoryIdList = classification.categoryIdList;
      List<String> categoryTitleList = [];
      for (var id in categoryIdList) {
        if (category.containsKey(id)) {
          if (category[id]!.group == groutItem.key) {
            categoryTitleList.add(category[id]!.title);
          }
        }
      }
      if (categoryTitleList.isNotEmpty) {
        categoryWidgetList.add(Text(
          '* ${groutItem.value.title} *',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ));
        categoryTitleList.sort();
        for (var categoryTitle in categoryTitleList) {
          categoryWidgetList.add(Text(
            '$categoryTitle',
          ));
        }
      }
    }

    lineList.add(
      Container(
        alignment: Alignment.topCenter,
        key: ValueKey(classId),
        child: Card(
          elevation: 25,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [richText],
                  ),
                ),
                ...categoryWidgetList,
              ],
            ),
          ),
        ),
      ),
    );
  }
  return lineList;
}

List<Widget> buildClassificationsHorizontal2({
  required BuildContext context,
  required Map<String, ClassGroup> group,
  required Map<String, ClassCategory> category,
  required Map<String, Classification> phraseClassifications,
  required List<String> phraseList,
  required List<int> selectedPhrasePosList,
}) {
  List<Widget> list = [];

  Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
      group, (key1, key2) => group[key1]!.title.compareTo(group[key2]!.title));

  for (var i = 0; i < phraseList.length; i++) {
    for (var phraseClassItem in phraseClassifications.entries) {
      List<int> phrasePosList = phraseClassItem.value.posPhraseList;
      // if (phrasePosList.contains(i)) {
      if (i == phrasePosList[0]) {
        // print('$i ${phraseClassItem.key} $phrasePosList');
        String phrase = '';
        for (var pos in phrasePosList) {
          try {
            phrase = phrase + phraseList[pos] + ' ';
          } catch (e) {}
        }

        List<Widget> categoryWidgetList = [];
        for (var groutItem in groupSorted.entries) {
          List<String> categoryIdList = phraseClassItem.value.categoryIdList;
          List<String> categoryTitleList = [];
          for (var id in categoryIdList) {
            if (category.containsKey(id)) {
              if (category[id]!.group == groutItem.key) {
                categoryTitleList.add(category[id]!.title);
              }
            }
          }
          if (categoryTitleList.isNotEmpty) {
            categoryWidgetList.add(Text(
              '* ${groutItem.value.title}:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ));
            categoryTitleList.sort();
            for (var categoryTitle in categoryTitleList) {
              categoryWidgetList.add(Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '    ~$categoryTitle',
                ),
              ));
            }
          }
        }
        list.add(
          Container(
            width: 200,
            padding: EdgeInsets.only(left: 10),
            // height: double.infinity,
            alignment: Alignment.topLeft,
            color: listEquals(selectedPhrasePosList, phrasePosList)
                ? Colors.yellow
                : null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$phrase',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    // scrollDirection: Axis.horizontal,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: categoryWidgetList,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  return list;
}

List<Widget> buildClassifications2({
  required BuildContext context,
  required Map<String, ClassGroup> group,
  required Map<String, ClassCategory> category2,
  required Map<String, Classification> phraseClassifications,
  required List<String> classOrder,
  required List<String> phraseList,
  required List<int> selectedPhrasePosList,
}) {
  List<Widget> list = [];
  Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
      group, (key1, key2) => group[key1]!.title.compareTo(group[key2]!.title));
  for (var groutItem in groupSorted.entries) {
    list.add(
      Container(
        width: double.infinity,
        color: Colors.black12,
        child: Center(
          child: Text('${groutItem.value.title}'),
        ),
      ),
    );
    // for (var i = 0; i < phraseList.length; i++) {
    //   for (var phraseClassItem in phraseClassifications.entries) {
    for (var classId in classOrder) {
      Classification classification = phraseClassifications[classId]!;

      List<int> phrasePosList = classification.posPhraseList;
      // if (i == phrasePosList[0]) {
      String phrase = '';
      for (var pos in phrasePosList) {
        try {
          phrase = phrase + phraseList[pos] + ' ';
        } catch (e) {}
      }
      List<String> phraseCategoryList = classification.categoryIdList;
      List<String> categoryTitleList = [];
      // for (var categoryItem in phraseCategoryList) {
      //   ClassCategory categoryTemp = category.putIfAbsent(
      //       categoryItem, () => ClassCategory(title: '', group: ''));

      //   if (categoryTemp.title.isNotEmpty &&
      //       categoryTemp.group == groutItem.key) {
      //     categoryTitleList.add(categoryTemp.title);
      //   }
      // }
      for (var id in phraseCategoryList) {
        if (category2.containsKey(id)) {
          if (category2[id]!.group == groutItem.key) {
            categoryTitleList.add(category2[id]!.title);
          }
        }
      }
      categoryTitleList.sort();
      String category = categoryTitleList.join(', ');

      if (category.isNotEmpty) {
        list.add(
          Container(
            color: listEquals(selectedPhrasePosList, phrasePosList)
                ? Colors.yellow
                : null,
            child: ListTile(
              title: Text('$phrase'),
              subtitle: Text('$category'),
            ),
          ),
        );
      }
      // }
    }
    // }
  }
  list.add(SizedBox(
    height: 20,
  ));
  return list;
}

List<InlineSpan> buildPhrase2({
  required BuildContext context,
  required List<String> phraseList,
  required List<int> selectedPhrasePosList,
  required Function(int) onSelectPhrase,
  required VoidCallback setState,
}) {
  List<InlineSpan> list = [];
  for (var wordPos = 0; wordPos < phraseList.length; wordPos++) {
    if (phraseList[wordPos] != ' ') {
      list.add(TextSpan(
        text: phraseList[wordPos],
        style: selectedPhrasePosList.contains(wordPos)
            ? TextStyle(
                color: Colors.orange.shade900,
                decoration: TextDecoration.underline,
                decorationStyle: TextDecorationStyle.solid,
              )
            : null,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // setState(() {});
            setState();
            onSelectPhrase(wordPos);
          },
      ));
    } else {
      list.add(TextSpan(
        text: phraseList[wordPos],
      ));
    }
  }

  return list;
}
