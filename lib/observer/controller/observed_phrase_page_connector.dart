import 'package:async_redux/async_redux.dart';
import 'package:classfrase/app_state.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../../classifying/controller/classifying_action.dart';
import '../observed_phrase_page.dart';
import 'observer_action.dart';

class ObservedPhrasePageConnector extends StatelessWidget {
  final String phraseId;

  const ObservedPhrasePageConnector({
    Key? key,
    required this.phraseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ObservedPhrasePageVm>(
      onInit: (store) {
        store.dispatch(SetObserverPhraseCurrentObserverAction(id: phraseId));
        // store.dispatch(SetPhraseListObservedPhrasePageAction());
      },
      vm: () => ObservedPhrasePageFactory(this),
      builder: (context, vm) => ObservedPhrasePage(
          phraseList: vm.phraseList,
          selectedPhrasePosList: vm.selectedPhrasePosList,
          onSelectPhrase: vm.onSelectPhrase,
          group: vm.group,
          category: vm.category,
          phraseClassifications: vm.phraseClassifications,
          observerPhraseCurrent: vm.observerPhraseCurrent,
          // onUpdateExistCategoryInPos: vm.onUpdateExistCategoryInPos,
          onSetNullSelectedPhraseAndCategory:
              vm.onSetNullSelectedPhraseAndCategory),
    );
  }
}

class ObservedPhrasePageFactory
    extends VmFactory<AppState, ObservedPhrasePageConnector> {
  ObservedPhrasePageFactory(widget) : super(widget);
  @override
  ObservedPhrasePageVm fromStore() => ObservedPhrasePageVm(
        phraseList: state.observerState.observerPhraseCurrent!.phraseList!,
        selectedPhrasePosList: state.classifyingState.selectedPosPhraseList!,
        group: state.classificationState.classificationCurrent!.group,
        category: state.classificationState.classificationCurrent!.category,
        onSelectPhrase: (int phrasePos) {
          dispatch(SetSelectedPhrasePosClassifyingAction(phrasePos: phrasePos));
        },
        phraseClassifications:
            state.observerState.observerPhraseCurrent!.classifications,
        observerPhraseCurrent: state.observerState.observerPhraseCurrent!,
        // onUpdateExistCategoryInPos: (String groupId) {
        //   dispatch(UpdateExistCategoryInPosObservedPhrasePageAction(groupId: groupId));
        // },
        onSetNullSelectedPhraseAndCategory: () {
          // dispatch(SetNullSelectedCategoryIdObservedPhrasePageAction());
          dispatch(SetNullSelectedPhrasePosClassifyingAction());
        },
      );
}

class ObservedPhrasePageVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Function(int) onSelectPhrase;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final PhraseModel observerPhraseCurrent;
  // final Function(String) onUpdateExistCategoryInPos;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  ObservedPhrasePageVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.group,
    required this.category,
    required this.onSelectPhrase,
    required this.phraseClassifications,
    required this.observerPhraseCurrent,
    // required this.onUpdateExistCategoryInPos,
    required this.onSetNullSelectedPhraseAndCategory,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
          group,
          category,
          phraseClassifications,
          observerPhraseCurrent
        ]);
}
