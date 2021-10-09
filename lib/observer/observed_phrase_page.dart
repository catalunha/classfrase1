import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';

import 'observed_person_tile.dart';

class ObservedPhrasePage extends StatefulWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;

  final Map<String, Classification> phraseClassifications;
  final PhraseModel observerPhraseCurrent;

  final Function(int) onSelectPhrase;
  // final Function(String) onUpdateExistCategoryInPos;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  const ObservedPhrasePage({
    Key? key,
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.group,
    required this.category,
    required this.phraseClassifications,
    required this.onSelectPhrase,
    // required this.onUpdateExistCategoryInPos,
    required this.onSetNullSelectedPhraseAndCategory,
    required this.observerPhraseCurrent,
  }) : super(key: key);

  @override
  _ObservedPhrasePageState createState() => _ObservedPhrasePageState();
}

class _ObservedPhrasePageState extends State<ObservedPhrasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Observando esta classificação'),
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
          ObservedPersonTile(
            phrase: widget.observerPhraseCurrent,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildClassifications(context),
              ),
            ),
          ),
        ],
      ),
    );
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
            child: Text('Classificações em ${groutItem.value.title}'),
          ),
        ),
      );
      for (var i = 0; i < widget.phraseList.length; i++) {
        for (var phraseClassItem in widget.phraseClassifications.entries) {
          // //print('${phraseClassItem.key}');
          // //print('${phraseClassItem.value.categoryIdList}');
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
            // //print('categoryItem: $phraseCategoryList');
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
    return list;
  }

  List<Widget> buildGroup(context) {
    List<Widget> list = [];
    for (var item in widget.group.entries) {
      list.add(
        TextButton(
          onPressed: () {
            if (widget.selectedPhrasePosList.isNotEmpty) {
              // widget.onUpdateExistCategoryInPos(item.key);
              // Navigator.pushNamed(context, '/classifications',
              //     arguments: item.key);
            } else {
              final snackBar = SnackBar(
                content: const Text('Oops. Selecone um trecho da frase.'),
                // action: SnackBarAction(
                //   label: 'Undo',
                //   onPressed: () {
                //     // Some code to undo the change.
                //   },
                // ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          child: Text('${item.value.title}'),
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: 20),
          ),
        ),
      );
    }
    return list;
  }

  List<InlineSpan> buildPhrase(context) {
    List<InlineSpan> list = [];
    for (var wordPos = 0; wordPos < widget.phraseList.length; wordPos++) {
      if (widget.phraseList[wordPos] != ' ') {
        list.add(TextSpan(
          text: widget.phraseList[wordPos],
          style: widget.selectedPhrasePosList.contains(wordPos)
              ? TextStyle(color: Colors.red)
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
