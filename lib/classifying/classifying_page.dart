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

// enum ClassBy { grupo, selecao, linha }

// extension ClassByExtension on ClassBy {
//   static const names = {
//     ClassBy.grupo: 'Classificação por GRUPO.',
//     ClassBy.selecao: 'Classificação por SELEÇÃO.',
//     ClassBy.linha: 'Classificação por LINHA.',
//   };
//   String get name => names[this]!;
// }

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
          Container(
            // width: double.infinity,
            color: Colors.black12,
            child: Center(
              child: Text('Selecione uma ou mais partes da frase.'),
            ),
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
          // Wrap(
          //   alignment: WrapAlignment.spaceEvenly,
          //   spacing: 5.0,
          //   children: buildGroup(context),
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
              // isHorizontal
              //     ? Expanded(
              //         child: Container(
              //             color: Colors.black12,
              //             child: Center(
              //                 child: Text('Classificação por SELEÇÃO.'))),
              //       )
              //     : Expanded(
              //         child: Container(
              //             color: Colors.black12,
              //             child:
              //                 Center(child: Text('Classificação por GRUPO.'))),
              //       ),
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
              //   icon: Icon(Icons.view_headline_rounded),
              //   onPressed: () {
              //     setState(() {
              //       classBy = ClassBy.linha;
              //     });
              //   },
              // )
              // PopupMenuButton(
              //   child: Icon(Icons.change_circle_outlined),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15.0)),
              //   itemBuilder: (BuildContext context) {
              //     return [
              //       PopupMenuItem(
              //         child: InkWell(
              //           child: Row(
              //             children: [
              //               Icon(AppIconData.info),
              //               SizedBox(
              //                 width: 5,
              //               ),
              //               Text('Classificar por Seleção'),
              //             ],
              //           ),
              //           onTap: () {
              //             Navigator.pop(context);
              //             Navigator.pushNamed(context, '/information');
              //           },
              //         ),
              //       ),
              //       PopupMenuItem(
              //         child: InkWell(
              //           child: Row(
              //             children: [
              //               Icon(AppIconData.coffee),
              //               SizedBox(
              //                 width: 5,
              //               ),
              //               Text('Classificar por grupo'),
              //             ],
              //           ),
              //           onTap: () {
              //             Navigator.pop(context);
              //             Navigator.pushNamed(context, '/coffee');
              //           },
              //         ),
              //       ),
              //     ];
              //   },
              // ),
            ],
          ),

          // isHorizontal
          //     ? Expanded(
          //         child: SingleChildScrollView(
          //           scrollDirection: Axis.horizontal,
          //           child: Row(
          //             // mainAxisSize: MainAxisSize.min,
          //             // crossAxisAlignment: CrossAxisAlignment.start,
          //             // mainAxisAlignment: MainAxisAlignment.center,

          //             children: buildClassificationsHorizontal(context),
          //           ),
          //         ),
          //       )
          //     : Expanded(
          //         child: SingleChildScrollView(
          //           child: Column(
          //             children: buildClassifications(context),
          //           ),
          //         ),
          //       ),
          if (classBy == ClassBy.grupo)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: buildClassifications2(
                    context: context,
                    group: widget.group,
                    category2: widget.category,
                    phraseClassifications: widget.phraseClassifications,
                    phraseList: widget.phraseList,
                    selectedPhrasePosList: widget.selectedPhrasePosList,
                  ),
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

          //         children: buildClassificationsHorizontal2(
          //           context: context,
          //           group: widget.group,
          //           category: widget.category,
          //           phraseClassifications: widget.phraseClassifications,
          //           phraseList: widget.phraseList,
          //           selectedPhrasePosList: widget.selectedPhrasePosList,
          //         ),
          //       ),
          //     ),
          //   ),
          if (classBy == ClassBy.selecao)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: buildClassByLine2(
                      context: context,
                      group: widget.group,
                      category: widget.category,
                      phraseClassifications: widget.phraseClassifications,
                      phraseList: widget.phraseList,
                    ),
                  ),
                ),
              ),
            ),
          // Text(''),
          // ...buildClassByLine(context),
        ],
      ),
    );
  }

  // List<Widget> buildClassByLine(context) {
  //   List<Widget> lineList = [];
  //   List<Widget> list = [];

  //   Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
  //       widget.group,
  //       (key1, key2) =>
  //           widget.group[key1]!.title.compareTo(widget.group[key2]!.title));
  //   // Map<String, Classification> classificationSorted = SplayTreeMap.from(
  //   //     widget.phraseClassifications,
  //   //     (key1, key2) => widget.phraseClassifications[key1]!.posPhraseList.join()
  //   //         .compareTo(
  //   //             widget.phraseClassifications[key2]!.posPhraseList.length));
  //   for (var i = 0; i < widget.phraseList.length; i++) {
  //     for (var classification in widget.phraseClassifications.entries) {
  //       List<int> phrasePosList = classification.value.posPhraseList;
  //       if (i == phrasePosList[0]) {
  //         List<InlineSpan> listSpan = [];
  //         for (var i = 0; i < widget.phraseList.length; i++) {
  //           listSpan.add(TextSpan(
  //             text: widget.phraseList[i],
  //             style: widget.phraseList[i] != ' ' &&
  //                     classification.value.posPhraseList.contains(i)
  //                 ? TextStyle(
  //                     color: Colors.orange.shade900,
  //                     decoration: TextDecoration.underline,
  //                     decorationStyle: TextDecorationStyle.solid,
  //                   )
  //                 : null,
  //           ));
  //         }
  //         RichText richText = RichText(
  //           text: TextSpan(
  //             style: TextStyle(fontSize: 28, color: Colors.black),
  //             children: listSpan,
  //           ),
  //         );

  //         List<Widget> categoryWidgetList = [];
  //         for (var groutItem in groupSorted.entries) {
  //           List<String> categoryIdList = classification.value.categoryIdList;
  //           List<String> categoryTitleList = [];
  //           for (var id in categoryIdList) {
  //             if (widget.category.containsKey(id)) {
  //               if (widget.category[id]!.group == groutItem.key) {
  //                 categoryTitleList.add(widget.category[id]!.title);
  //               }
  //             }
  //           }
  //           if (categoryTitleList.isNotEmpty) {
  //             categoryWidgetList.add(Text(
  //               '* ${groutItem.value.title} *',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: Colors.black,
  //               ),
  //             ));
  //             categoryTitleList.sort();
  //             for (var categoryTitle in categoryTitleList) {
  //               categoryWidgetList.add(Text(
  //                 '$categoryTitle',
  //               ));
  //             }
  //           }
  //         }

  //         lineList.add(
  //           Card(
  //             elevation: 25,
  //             child: Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Column(
  //                 children: [
  //                   SingleChildScrollView(
  //                     scrollDirection: Axis.horizontal,
  //                     child: Row(
  //                       children: [richText],
  //                     ),
  //                   ),
  //                   ...categoryWidgetList,
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }
  //   return lineList;
  // }

  // List<Widget> buildClassificationsHorizontal(context) {
  //   List<Widget> list = [];

  //   Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
  //       widget.group,
  //       (key1, key2) =>
  //           widget.group[key1]!.title.compareTo(widget.group[key2]!.title));

  //   for (var i = 0; i < widget.phraseList.length; i++) {
  //     for (var phraseClassItem in widget.phraseClassifications.entries) {
  //       List<int> phrasePosList = phraseClassItem.value.posPhraseList;
  //       // if (phrasePosList.contains(i)) {
  //       if (i == phrasePosList[0]) {
  //         // print('$i ${phraseClassItem.key} $phrasePosList');
  //         String phrase = '';
  //         for (var pos in phrasePosList) {
  //           try {
  //             phrase = phrase + widget.phraseList[pos] + ' ';
  //           } catch (e) {}
  //         }

  //         List<Widget> categoryWidgetList = [];
  //         for (var groutItem in groupSorted.entries) {
  //           List<String> categoryIdList = phraseClassItem.value.categoryIdList;
  //           List<String> categoryTitleList = [];
  //           for (var id in categoryIdList) {
  //             if (widget.category.containsKey(id)) {
  //               if (widget.category[id]!.group == groutItem.key) {
  //                 categoryTitleList.add(widget.category[id]!.title);
  //               }
  //             }
  //           }
  //           if (categoryTitleList.isNotEmpty) {
  //             categoryWidgetList.add(Text(
  //               '* ${groutItem.value.title}:',
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: Colors.black,
  //               ),
  //             ));
  //             categoryTitleList.sort();
  //             for (var categoryTitle in categoryTitleList) {
  //               categoryWidgetList.add(Padding(
  //                 padding: const EdgeInsets.only(left: 8.0),
  //                 child: Text(
  //                   '    ~$categoryTitle',
  //                 ),
  //               ));
  //             }
  //           }
  //         }
  //         list.add(
  //           Container(
  //             width: 200,
  //             padding: EdgeInsets.only(left: 10),
  //             // height: double.infinity,
  //             alignment: Alignment.topLeft,
  //             color: listEquals(widget.selectedPhrasePosList, phrasePosList)
  //                 ? Colors.yellow
  //                 : null,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   '$phrase',
  //                   style: TextStyle(fontSize: 28, color: Colors.black),
  //                 ),
  //                 Expanded(
  //                   child: SingleChildScrollView(
  //                     // scrollDirection: Axis.horizontal,
  //                     child: Column(
  //                       // mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: categoryWidgetList,
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 10,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }

  //   return list;
  // }

  // List<Widget> buildClassifications(context) {
  //   List<Widget> list = [];
  //   Map<String, ClassGroup> groupSorted = SplayTreeMap.from(
  //       widget.group,
  //       (key1, key2) =>
  //           widget.group[key1]!.title.compareTo(widget.group[key2]!.title));
  //   for (var groutItem in groupSorted.entries) {
  //     list.add(
  //       Container(
  //         width: double.infinity,
  //         color: Colors.black12,
  //         child: Center(
  //           child: Text('${groutItem.value.title}'),
  //         ),
  //       ),
  //     );
  //     for (var i = 0; i < widget.phraseList.length; i++) {
  //       for (var phraseClassItem in widget.phraseClassifications.entries) {
  //         List<int> phrasePosList = phraseClassItem.value.posPhraseList;
  //         if (i == phrasePosList[0]) {
  //           String phrase = '';
  //           for (var pos in phrasePosList) {
  //             try {
  //               phrase = phrase + widget.phraseList[pos] + ' ';
  //             } catch (e) {}
  //           }
  //           List<String> phraseCategoryList =
  //               phraseClassItem.value.categoryIdList;
  //           List<String> categoryTitleList = [];
  //           // for (var categoryItem in phraseCategoryList) {
  //           //   ClassCategory categoryTemp = widget.category.putIfAbsent(
  //           //       categoryItem, () => ClassCategory(title: '', group: ''));

  //           //   if (categoryTemp.title.isNotEmpty &&
  //           //       categoryTemp.group == groutItem.key) {
  //           //     categoryTitleList.add(categoryTemp.title);
  //           //   }
  //           // }
  //           for (var id in phraseCategoryList) {
  //             if (widget.category.containsKey(id)) {
  //               if (widget.category[id]!.group == groutItem.key) {
  //                 categoryTitleList.add(widget.category[id]!.title);
  //               }
  //             }
  //           }
  //           categoryTitleList.sort();
  //           String category = categoryTitleList.join(', ');

  //           if (category.isNotEmpty) {
  //             list.add(
  //               Container(
  //                 color: listEquals(widget.selectedPhrasePosList, phrasePosList)
  //                     ? Colors.yellow
  //                     : null,
  //                 child: ListTile(
  //                   title: Text('$phrase'),
  //                   subtitle: Text('$category'),
  //                 ),
  //               ),
  //             );
  //           }
  //         }
  //       }
  //     }
  //   }
  //   list.add(SizedBox(
  //     height: 20,
  //   ));
  //   return list;
  // }

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
      // list.add(
      //   SizedBox(
      //     width: 10,
      //   ),
      // );
    }
    return list;
  }

  void setStateLocal() {
    setState(() {});
  }

  // List<InlineSpan> buildPhrase(context) {
  //   List<InlineSpan> list = [];
  //   for (var wordPos = 0; wordPos < widget.phraseList.length; wordPos++) {
  //     if (widget.phraseList[wordPos] != ' ') {
  //       list.add(TextSpan(
  //         text: widget.phraseList[wordPos],
  //         style: widget.selectedPhrasePosList.contains(wordPos)
  //             ? TextStyle(
  //                 color: Colors.orange.shade900,
  //                 decoration: TextDecoration.underline,
  //                 decorationStyle: TextDecorationStyle.solid,
  //               )
  //             : null,
  //         recognizer: TapGestureRecognizer()
  //           ..onTap = () {
  //             setState(() {});
  //             widget.onSelectPhrase(wordPos);
  //           },
  //       ));
  //     } else {
  //       list.add(TextSpan(
  //         text: widget.phraseList[wordPos],
  //       ));
  //     }
  //   }

  //   return list;
  // }
}
