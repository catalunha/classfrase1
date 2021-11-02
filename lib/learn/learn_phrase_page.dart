import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/classifying/controller/classification_type.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'person_tile.dart';

class LearnPhrasePage extends StatefulWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final List<ClassGroup> groupList;
  final Map<String, ClassCategory> category;

  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;

  final PhraseModel phraseCurrent;

  final Function(int) onSelectPhrase;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  const LearnPhrasePage({
    Key? key,
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.groupList,
    required this.category,
    required this.phraseClassifications,
    required this.onSelectPhrase,
    required this.onSetNullSelectedPhraseAndCategory,
    required this.phraseCurrent,
    required this.classOrder,
  }) : super(key: key);

  @override
  _LearnPhrasePageState createState() => _LearnPhrasePageState();
}

class _LearnPhrasePageState extends State<LearnPhrasePage> {
  ClassBy classBy = ClassBy.selecao;

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
                  style: TextStyle(
                    fontSize: 28,
                    // color: Colors.black,
                  ),
                  children: buildPhraseNoSelectable(
                    context: context,
                    phraseList: widget.phraseList,
                    selectedPhrasePosList: widget.selectedPhrasePosList,
                  ),
                ),
              ),
            ),
          ),
          PersonTile(
            displayName: widget.phraseCurrent.userRef.displayName,
            photoURL: widget.phraseCurrent.userRef.photoURL,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (classBy == ClassBy.grupo)
                Expanded(
                  child: Container(
                      // color: Colors.black12,
                      child: Center(child: Text(ClassBy.grupo.name))),
                ),
              if (classBy == ClassBy.selecao)
                Expanded(
                  child: Container(
                      // color: Colors.black12,
                      child: Center(child: Text(ClassBy.selecao.name))),
                ),
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
            ],
          ),
          if (classBy == ClassBy.grupo)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: buildClassifications2(
                    context: context,
                    groupList: widget.groupList,
                    category2: widget.category,
                    phraseClassifications: widget.phraseClassifications,
                    classOrder: widget.classOrder,
                    phraseList: widget.phraseList,
                    selectedPhrasePosList: widget.selectedPhrasePosList,
                  ),
                ),
              ),
            ),
          if (classBy == ClassBy.selecao)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: buildClassByLine2(
                      context: context,
                      groupList: widget.groupList,
                      category: widget.category,
                      phraseClassifications: widget.phraseClassifications,
                      classOrder: widget.classOrder,
                      phraseList: widget.phraseList,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
