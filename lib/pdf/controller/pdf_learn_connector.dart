import 'package:async_redux/async_redux.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/learn/controller/learn_action.dart';
import 'package:classfrase/phrase/controller/phrase_action.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../pdf_learn_page.dart';
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
        group: vm.group,
        category: vm.category,
        phraseClassifications: vm.phraseClassifications,
        classOrder: vm.classOrder,
        authorDisplayName: vm.authorDisplayName,
        authorPhoto: vm.authorPhoto,
      ),
    );
  }
}

class ClassifyingFactory extends VmFactory<AppState, PdfLearnConnector> {
  ClassifyingFactory(widget) : super(widget);
  @override
  ClassifyingVm fromStore() => ClassifyingVm(
        phraseList: state.learnState.phraseCurrent!.phraseList,
        group: state.classificationState.classificationCurrent!.group,
        category: state.classificationState.classificationCurrent!.category,
        phraseClassifications: state.learnState.phraseCurrent!.classifications,
        classOrder: state.learnState.phraseCurrent!.classOrder,
        authorDisplayName:
            state.learnState.phraseCurrent!.userRef.displayName ?? '',
        authorPhoto: state.learnState.phraseCurrent!.userRef.photoURL ?? '',
      );
}

class ClassifyingVm extends Vm {
  final String authorDisplayName;
  final String authorPhoto;
  final List<String> phraseList;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;

  ClassifyingVm({
    required this.authorDisplayName,
    required this.authorPhoto,
    required this.phraseList,
    required this.group,
    required this.category,
    required this.phraseClassifications,
    required this.classOrder,
  }) : super(equals: [
          authorDisplayName,
          authorPhoto,
          phraseList,
          group,
          category,
          phraseClassifications,
          classOrder,
        ]);
}
