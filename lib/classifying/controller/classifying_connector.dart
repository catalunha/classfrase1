import 'package:async_redux/async_redux.dart';
import 'package:classfrase/app_state.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_action.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../classifying_page.dart';
import 'classifying_action.dart';

class ClassifyingConnector extends StatelessWidget {
  final String phraseId;

  const ClassifyingConnector({
    Key? key,
    required this.phraseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClassifyingVm>(
      onInit: (store) {
        store.dispatch(SetPhraseCurrentPhraseAction(id: phraseId));
        // store.dispatch(SetPhraseListClassifyingAction());
      },
      vm: () => ClassifyingFactory(this),
      builder: (context, vm) => ClassifyingPage(
          phraseList: vm.phraseList,
          selectedPhrasePosList: vm.selectedPhrasePosList,
          onSelectPhrase: vm.onSelectPhrase,
          group: vm.group,
          category: vm.category,
          phraseClassifications: vm.phraseClassifications,
          onUpdateExistCategoryInPos: vm.onUpdateExistCategoryInPos,
          onSetNullSelectedPhraseAndCategory:
              vm.onSetNullSelectedPhraseAndCategory),
    );
  }
}

class ClassifyingFactory extends VmFactory<AppState, ClassifyingConnector> {
  ClassifyingFactory(widget) : super(widget);
  @override
  ClassifyingVm fromStore() => ClassifyingVm(
        phraseList: state.phraseState.phraseCurrent!.phraseList!,
        selectedPhrasePosList: state.classifyingState.selectedPosPhraseList!,
        group: state.classificationState.classificationCurrent!.group,
        category: state.classificationState.classificationCurrent!.category,
        onSelectPhrase: (int phrasePos) {
          dispatch(SetSelectedPhrasePosClassifyingAction(phrasePos: phrasePos));
        },
        phraseClassifications: state.phraseState.phraseCurrent!.classifications,
        onUpdateExistCategoryInPos: (String groupId) {
          dispatch(UpdateExistCategoryInPosClassifyingAction(groupId: groupId));
        },
        onSetNullSelectedPhraseAndCategory: () {
          dispatch(SetNullSelectedCategoryIdClassifyingAction());
          dispatch(SetNullSelectedPhrasePosClassifyingAction());
        },
      );
}

class ClassifyingVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Function(int) onSelectPhrase;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final Function(String) onUpdateExistCategoryInPos;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  ClassifyingVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.group,
    required this.category,
    required this.onSelectPhrase,
    required this.phraseClassifications,
    required this.onUpdateExistCategoryInPos,
    required this.onSetNullSelectedPhraseAndCategory,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
          group,
          category,
          phraseClassifications,
        ]);
}
