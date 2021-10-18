import 'dart:collection';

import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/classifying/controller/classification_type.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'person_tile.dart';

class LearnPhrasePage extends StatefulWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;

  final Map<String, Classification> phraseClassifications;
  final PhraseModel phraseCurrent;

  final Function(int) onSelectPhrase;
  // final Function(String) onUpdateExistCategoryInPos;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  const LearnPhrasePage({
    Key? key,
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.group,
    required this.category,
    required this.phraseClassifications,
    required this.onSelectPhrase,
    // required this.onUpdateExistCategoryInPos,
    required this.onSetNullSelectedPhraseAndCategory,
    required this.phraseCurrent,
  }) : super(key: key);

  @override
  _LearnPhrasePageState createState() => _LearnPhrasePageState();
}

class _LearnPhrasePageState extends State<LearnPhrasePage> {
  ClassBy classBy = ClassBy.grupo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classificação'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            widget.onSetNullSelectedPhraseAndCategory();
            Navigator.pop(context);
          },
        ),
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
          PersonTile(
            displayName: widget.phraseCurrent.userRef.displayName,
            photoURL: widget.phraseCurrent.userRef.photoURL,
          ),
          // Expanded(
          //   child: SingleChildScrollView(
          //     child: Column(
          //       children: buildClassifications(context),
          //     ),
          //   ),
          // ),
          // Tooltip(
          //   message: 'Clique no box de seleção para mudar modo de visão',
          //   child: CheckboxListTile(
          //     title: isHorizontal
          //         ? Container(
          //             // width: double.infinity,
          //             color: Colors.black12,
          //             child: Center(
          //               child: Text('Sua classificação por seleção.'),
          //             ),
          //           )
          //         : Container(
          //             // width: double.infinity,
          //             color: Colors.black12,
          //             child: Center(
          //               child: Text('Sua classificação por grupos.'),
          //             ),
          //           ),
          //     onChanged: (value) {
          //       setState(() {
          //         isHorizontal = value!;
          //       });
          //     },
          //     value: isHorizontal,
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (classBy == ClassBy.grupo)
                Expanded(
                  child: Container(
                      color: Colors.black12,
                      child: Center(child: Text(ClassBy.grupo.name))),
                ),
              if (classBy == ClassBy.selecao)
                Expanded(
                  child: Container(
                      color: Colors.black12,
                      child: Center(child: Text(ClassBy.selecao.name))),
                ),
              // if (classBy == ClassBy.linha)
              //   Expanded(
              //     child: Container(
              //         color: Colors.black12,
              //         child: Center(child: Text(ClassBy.linha.name))),
              //   ),
              IconButton(
                tooltip: ClassBy.selecao.name,
                icon: Icon(ClassBy.selecao.icon),
                onPressed: () {
                  setState(() {
                    classBy = ClassBy.selecao;
                  });
                },
              ),
              IconButton(
                tooltip: ClassBy.grupo.name,
                icon: Icon(ClassBy.grupo.icon),
                onPressed: () {
                  setState(() {
                    classBy = ClassBy.grupo;
                  });
                },
              ),

              // IconButton(
              //   tooltip: ClassBy.linha.name,
              //   icon: Icon(ClassBy.linha.icon),
              //   onPressed: () {
              //     setState(() {
              //       classBy = ClassBy.linha;
              //     });
              //   },
              // )
            ],
          ),
          if (classBy == ClassBy.grupo)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: buildClassifications(context),
                ),
              ),
            ),

          // if (classBy == ClassBy.selecao)
          //   Expanded(
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         // mainAxisSize: MainAxisSize.min,
          //         // crossAxisAlignment: CrossAxisAlignment.start,
          //         // mainAxisAlignment: MainAxisAlignment.center,

          //         children: buildClassificationsHorizontal(context),
          //       ),
          //     ),
          //   ),
          if (classBy == ClassBy.selecao)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: buildClassByLine(context),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> buildClassByLine(context) {
    List<Widget> lineList = [];
    List<Widget> list = [];

    Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
        widget.group,
        (key1, key2) =>
            widget.group[key1]!.title.compareTo(widget.group[key2]!.title));
    for (var i = 0; i < widget.phraseList.length; i++) {
      for (var classification in widget.phraseClassifications.entries) {
        List<int> phrasePosList = classification.value.posPhraseList;
        if (i == phrasePosList[0]) {
          List<InlineSpan> listSpan = [];
          for (var i = 0; i < widget.phraseList.length; i++) {
            listSpan.add(TextSpan(
              text: widget.phraseList[i],
              style: widget.phraseList[i] != ' ' &&
                      classification.value.posPhraseList.contains(i)
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
            List<String> categoryIdList = classification.value.categoryIdList;
            List<String> categoryTitleList = [];
            for (var id in categoryIdList) {
              if (widget.category.containsKey(id)) {
                if (widget.category[id]!.group == groutItem.key) {
                  categoryTitleList.add(widget.category[id]!.title);
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
            Card(
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
          );
        }
      }
    }

    return lineList;
  }

  List<Widget> buildClassificationsHorizontal(context) {
    List<Widget> list = [];

    Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
        widget.group,
        (key1, key2) =>
            widget.group[key1]!.title.compareTo(widget.group[key2]!.title));

    for (var i = 0; i < widget.phraseList.length; i++) {
      for (var phraseClassItem in widget.phraseClassifications.entries) {
        List<int> phrasePosList = phraseClassItem.value.posPhraseList;
        // if (phrasePosList.contains(i)) {
        if (i == phrasePosList[0]) {
          // print('$i ${phraseClassItem.key} $phrasePosList');
          String phrase = '';
          for (var pos in phrasePosList) {
            try {
              phrase = phrase + widget.phraseList[pos] + ' ';
            } catch (e) {}
          }

          List<Widget> categoryWidgetList = [];
          for (var groutItem in groupSorted.entries) {
            List<String> categoryIdList = phraseClassItem.value.categoryIdList;
            List<String> categoryTitleList = [];
            for (var id in categoryIdList) {
              if (widget.category.containsKey(id)) {
                if (widget.category[id]!.group == groutItem.key) {
                  categoryTitleList.add(widget.category[id]!.title);
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
                    '~$categoryTitle',
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
              color: listEquals(widget.selectedPhrasePosList, phrasePosList)
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

  List<Widget> buildClassifications(context) {
    List<Widget> list = [];
    Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
        widget.group,
        (key1, key2) =>
            widget.group[key1]!.title.compareTo(widget.group[key2]!.title));
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
      for (var i = 0; i < widget.phraseList.length; i++) {
        for (var phraseClassItem in widget.phraseClassifications.entries) {
          List<int> phrasePosList = phraseClassItem.value.posPhraseList;
          if (i == phrasePosList[0]) {
            String phrase = '';
            for (var pos in phrasePosList) {
              try {
                phrase = phrase + widget.phraseList[pos] + ' ';
              } catch (e) {}
            }
            List<String> phraseCategoryList =
                phraseClassItem.value.categoryIdList;
            List<String> categoryTitleList = [];
            for (var categoryItem in phraseCategoryList) {
              ClassCategory categoryTemp = widget.category.putIfAbsent(
                  categoryItem, () => ClassCategory(title: '', group: ''));

              if (categoryTemp.title.isNotEmpty &&
                  categoryTemp.group == groutItem.key) {
                categoryTitleList.add(categoryTemp.title);
              }
            }
            categoryTitleList.sort();
            String category = categoryTitleList.join(', ');

            if (category.isNotEmpty) {
              list.add(
                Container(
                  color: listEquals(widget.selectedPhrasePosList, phrasePosList)
                      ? Colors.yellow
                      : null,
                  child: ListTile(
                    title: Text('$phrase'),
                    subtitle: Text('$category'),
                  ),
                ),
              );
            }
          }
        }
      }
    }
    list.add(SizedBox(
      height: 20,
    ));
    return list;
  }

  List<InlineSpan> buildPhrase(context) {
    List<InlineSpan> list = [];
    for (var wordPos = 0; wordPos < widget.phraseList.length; wordPos++) {
      if (widget.phraseList[wordPos] != ' ') {
        list.add(TextSpan(
          text: widget.phraseList[wordPos],
          style: widget.selectedPhrasePosList.contains(wordPos)
              ? TextStyle(
                  color: Colors.orange.shade900,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                )
              : null,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {});
              widget.onSelectPhrase(wordPos);
            },
        ));
      } else {
        list.add(TextSpan(
          text: widget.phraseList[wordPos],
        ));
      }
    }

    return list;
  }
}
