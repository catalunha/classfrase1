import 'package:async_redux/async_redux.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/learn/controller/learn_action.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../pdf_page.dart';

class PdfLearnConnector extends StatelessWidget {
  final String phraseId;

  const PdfLearnConnector({
    Key? key,
    required this.phraseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClassifyingVm>(
      onInit: (store) {
        store.dispatch(SetPhraseCurrentLearnAction(id: phraseId));
      },
      vm: () => ClassifyingFactory(this),
      builder: (context, vm) => PdfPage(
        phraseList: vm.phraseList,
        groupList: vm.groupList,
        category: vm.category,
        phraseClassifications: vm.phraseClassifications,
        classOrder: vm.classOrder,
        phraseFont: vm.phraseFont,
        authorDisplayName: vm.authorDisplayName,
        authorPhoto: vm.authorPhoto,
        pdfFileName: vm.pdfFileName,
        diagramUrl: vm.diagramUrl,
      ),
    );
  }
}

class ClassifyingFactory extends VmFactory<AppState, PdfLearnConnector> {
  ClassifyingFactory(widget) : super(widget);
  @override
  ClassifyingVm fromStore() => ClassifyingVm(
        phraseList: state.learnState.phraseCurrent!.phraseList,
        groupList: groupListSorted(),
        category: state.classificationState.classificationCurrent!.category,
        phraseClassifications: state.learnState.phraseCurrent!.classifications,
        classOrder: state.learnState.phraseCurrent!.classOrder,
        authorDisplayName:
            state.learnState.phraseCurrent!.userRef.displayName ?? '',
        authorPhoto: state.learnState.phraseCurrent!.userRef.photoURL ?? '',
        phraseFont: state.learnState.phraseCurrent!.font ?? '',
        pdfFileName: state.learnState.phraseCurrent!.id,
        diagramUrl: state.phraseState.phraseCurrent!.diagramUrl ?? '',
      );
  List<ClassGroup> groupListSorted() {
    Map<String, ClassGroup> group =
        state.classificationState.classificationCurrent!.group;
    List<ClassGroup> groupList = group.entries.map((e) => e.value).toList();
    groupList.sort((a, b) => a.title.compareTo(b.title));
    return groupList;
  }
}

class ClassifyingVm extends Vm {
  final String authorDisplayName;
  final String authorPhoto;
  final String phraseFont;
  final String pdfFileName;
  final String diagramUrl;

  final List<String> phraseList;
  final List<ClassGroup> groupList;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;

  ClassifyingVm({
    required this.authorDisplayName,
    required this.authorPhoto,
    required this.phraseFont,
    required this.pdfFileName,
    required this.diagramUrl,
    required this.phraseList,
    required this.groupList,
    required this.category,
    required this.phraseClassifications,
    required this.classOrder,
  }) : super(equals: [
          authorDisplayName,
          authorPhoto,
          pdfFileName,
          diagramUrl,
          phraseFont,
          phraseList,
          groupList,
          category,
          phraseClassifications,
          classOrder,
        ]);
}
