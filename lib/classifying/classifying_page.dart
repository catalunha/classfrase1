import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';

import 'controller/classification_type.dart';

class ClassifyingPage extends StatefulWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;

  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;
  final Function(List<String>) onChangeClassOrder;

  final Function(int) onSelectPhrase;
  final Function(bool?) onSelectAllPhrase;

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
    required this.classOrder,
    required this.onChangeClassOrder,
    required this.onSelectAllPhrase,
  }) : super(key: key);

  @override
  _ClassifyingPageState createState() => _ClassifyingPageState();
}

class _ClassifyingPageState extends State<ClassifyingPage> {
  bool isHorizontal = true;
  ClassBy classBy = ClassBy.selecao;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classificando esta frase'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            widget.onSetNullSelectedPhraseAndCategory();
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  color: Colors.black12,
                  child: Center(
                    child: Text('Selecione partes da frase.'),
                  ),
                ),
              ),
              IconButton(
                tooltip: 'ou clique aqui para selecionar a frase toda.',
                icon: Icon(Icons.check_circle_outline),
                onPressed: () {
                  setState(() {
                    widget.onSelectAllPhrase(true);
                  });
                },
              ),
              IconButton(
                tooltip: 'ou clique aqui para limpar toda seleção.',
                icon: Icon(Icons.highlight_off),
                onPressed: () {
                  setState(() {
                    widget.onSelectAllPhrase(false);
                  });
                },
              ),
              IconButton(
                tooltip: 'ou clique aqui para inverter seleção.',
                icon: Icon(Icons.change_circle_outlined),
                onPressed: () {
                  setState(() {
                    widget.onSelectAllPhrase(null);
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 28, color: Colors.black),
                  children: buildPhrase2(
                    context: context,
                    phraseList: widget.phraseList,
                    selectedPhrasePosList: widget.selectedPhrasePosList,
                    onSelectPhrase: widget.onSelectPhrase,
                    setState: setStateLocal,
                  ),
                ),
              ),
            ),
          ),
          Container(
            // width: double.infinity,
            color: Colors.black12,
            child: Center(
              child: Text('Clique num grupo para escolher uma classificação.'),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: buildGroup(context),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
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
                      child: Center(
                          child: Column(
                        children: [
                          Text(ClassBy.selecao.name),
                          Text('Você pode reordenar esta lista.',
                              style: TextStyle(fontSize: 12))
                        ],
                      ))),
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
                  // children: buildClassifications(context),
                  children: buildClassifications2(
                    context: context,
                    group: widget.group,
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
                child: ReorderableListView(
                  onReorder: _onReorder,

                  // children: buildClassByLine(context),
                  children: buildClassByLine2(
                    context: context,
                    group: widget.group,
                    category: widget.category,
                    phraseClassifications: widget.phraseClassifications,
                    classOrder: widget.classOrder,
                    phraseList: widget.phraseList,
                  ),
                  // ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
    List<String> classOrderTemp = widget.classOrder;
    String resourceId = classOrderTemp[oldIndex];
    classOrderTemp.removeAt(oldIndex);
    classOrderTemp.insert(newIndex, resourceId);
    widget.onChangeClassOrder(classOrderTemp);
  }

  List<Widget> buildGroup(context) {
    List<Widget> list = [];
    Map<String, ClassGroup> sorted = SplayTreeMap.from(
        widget.group,
        (key1, key2) =>
            widget.group[key1]!.title.compareTo(widget.group[key2]!.title));

    for (var item in sorted.entries) {
      list.add(
        TextButton(
          onPressed: () {
            if (widget.selectedPhrasePosList.isNotEmpty) {
              widget.onUpdateExistCategoryInPos(item.key);
              Navigator.pushNamed(context, '/classifications',
                  arguments: item.key);
            } else {
              final snackBar = SnackBar(
                content: const Text('Oops. Selecione um trecho da frase.'),
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
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }
    return list;
  }

  void setStateLocal() {
    setState(() {});
  }
}
