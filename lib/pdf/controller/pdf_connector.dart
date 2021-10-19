import 'package:async_redux/async_redux.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_action.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../pdf_page.dart';

class PdfConnector extends StatelessWidget {
  final String phraseId;

  const PdfConnector({
    Key? key,
    required this.phraseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClassifyingVm>(
      onInit: (store) {
        store.dispatch(SetPhraseCurrentPhraseAction(id: phraseId));
      },
      vm: () => ClassifyingFactory(this),
      builder: (context, vm) => PdfPage(
        phraseList: vm.phraseList,
        group: vm.group,
        category: vm.category,
        phraseClassifications: vm.phraseClassifications,
        classOrder: vm.classOrder,
      ),
    );
  }
}

class ClassifyingFactory extends VmFactory<AppState, PdfConnector> {
  ClassifyingFactory(widget) : super(widget);
  @override
  ClassifyingVm fromStore() => ClassifyingVm(
        phraseList: state.phraseState.phraseCurrent!.phraseList,
        group: state.classificationState.classificationCurrent!.group,
        category: state.classificationState.classificationCurrent!.category,
        phraseClassifications: state.phraseState.phraseCurrent!.classifications,
        classOrder: state.phraseState.phraseCurrent!.classOrder,
      );
}

class ClassifyingVm extends Vm {
  final List<String> phraseList;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;

  ClassifyingVm({
    required this.phraseList,
    required this.group,
    required this.category,
    required this.phraseClassifications,
    required this.classOrder,
  }) : super(equals: [
          phraseList,
          group,
          category,
          phraseClassifications,
          classOrder,
        ]);
}
