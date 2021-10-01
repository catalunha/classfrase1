import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';

class ClassifyingPage extends StatefulWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;

  final Map<String, Classification> phraseClassifications;

  final Function(int) onSelectPhrase;
  final Function(String) onUpdateExistCategoryInPos;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  const ClassifyingPage({
    Key? key,
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.group,
    required this.category,
    required this.phraseClassifications,
    required this.onSelectPhrase,
    required this.onUpdateExistCategoryInPos,
    required this.onSetNullSelectedPhraseAndCategory,
  }) : super(key: key);

  @override
  _ClassifyingPageState createState() => _ClassifyingPageState();
}

class _ClassifyingPageState extends State<ClassifyingPage> {
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
          Wrap(
            children: buildGroup(context),
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
    for (var groutItem in widget.group.entries) {
      list.add(
        Container(
          width: double.infinity,
          color: Colors.black12,
          child: Center(
            child: Text('Classificação ${groutItem.value.title}'),
          ),
        ),
      );
      for (var i = 0; i < widget.phraseList.length; i++) {
        for (var phraseClassItem in widget.phraseClassifications.entries) {
          // print('${phraseClassItem.key}');
          // print('${phraseClassItem.value.categoryIdList}');
          List<int> phrasePosList = phraseClassItem.value.posPhraseList;
          if (i == phrasePosList[0]) {
            String phrase = '';
            for (var pos in phrasePosList) {
              phrase = phrase + widget.phraseList[pos] + ' ';
            }
            List<String> phraseCategoryList =
                phraseClassItem.value.categoryIdList;
            List<String> categoryTitleList = [];
            // print('categoryItem: $phraseCategoryList');
            for (var categoryItem in phraseCategoryList) {
              ClassCategory categoryTemp = widget.category.putIfAbsent(
                  categoryItem, () => ClassCategory(title: '', type: ''));
              if (categoryTemp.title.isNotEmpty &&
                  categoryTemp.type == groutItem.key) {
                categoryTitleList.add(categoryTemp.title);
              }
            }
            categoryTitleList.sort();
            String category = categoryTitleList.join(', ');

            if (category.isNotEmpty) {
              list.add(
                ListTile(
                  tileColor:
                      listEquals(widget.selectedPhrasePosList, phrasePosList)
                          ? Colors.amber.shade100
                          : null,
                  title: Text('$phrase'),
                  subtitle: Text('$category'),
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
              widget.onUpdateExistCategoryInPos(item.key);
              Navigator.pushNamed(context, '/classifications',
                  arguments: item.key);
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
      list.add(TextSpan(
        text: ' ',
      ));
    }

    return list;
  }
}
