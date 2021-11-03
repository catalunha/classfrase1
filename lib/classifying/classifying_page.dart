import 'package:classfrase/theme/app_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';

import 'controller/classification_type.dart';

class ClassifyingPage extends StatefulWidget {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final List<ClassGroup> groupList;
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
    required this.groupList,
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
                  color: MyTheme.backgroundTitle,
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
                  style: TextStyle(
                    fontSize: 28,
                    color: MyTheme.onBackgroundColor,
                  ),
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
            color: MyTheme.backgroundTitle,
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
                      // color: Colors.black12,
                      child: Center(child: Text(ClassBy.grupo.name))),
                ),
              if (classBy == ClassBy.selecao)
                Expanded(
                  child: Container(
                      color: MyTheme.backgroundTitle,
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
                  children: buildClassifications2(
                    context: context,
                    groupList: widget.groupList,
                    category2: widget.category,
                    phraseClassifications: widget.phraseClassifications,
                    classOrder: widget.classOrder,
                    phraseList: widget.phraseList,
                    selectedPhrasePosList: widget.selectedPhrasePosList,
                    onSelectPhrase: widget.onSelectPhrase,
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
                  children: buildClassByLine2(
                    context: context,
                    groupList: widget.groupList,
                    category: widget.category,
                    phraseClassifications: widget.phraseClassifications,
                    classOrder: widget.classOrder,
                    phraseList: widget.phraseList,
                    onSelectPhrase: widget.onSelectPhrase,
                  ),
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

    for (var group in widget.groupList) {
      list.add(
        TextButton(
          onPressed: () {
            if (widget.selectedPhrasePosList.isNotEmpty) {
              widget.onUpdateExistCategoryInPos(group.id!);
              Navigator.pushNamed(context, '/classifications',
                  arguments: group.id);
            } else {
              final snackBar = SnackBar(
                content: const Text('Oops. Selecione um trecho da frase.'),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
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

  void setStateLocal() {
    setState(() {});
  }
}
