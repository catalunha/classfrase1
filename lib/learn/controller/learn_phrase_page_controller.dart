import 'package:async_redux/async_redux.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/classifying/controller/classifying_action.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../learn_phrase_page.dart';
import 'learn_action.dart';

class LearnPhrasePageConnector extends StatelessWidget {
  final String phraseId;

  const LearnPhrasePageConnector({
    Key? key,
    required this.phraseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LearnPhrasePageVm>(
      onInit: (store) {
        store.dispatch(SetPhraseCurrentLearnAction(id: phraseId));
      },
      vm: () => LearnPhrasePageFactory(this),
      builder: (context, vm) => LearnPhrasePage(
          phraseList: vm.phraseList,
          selectedPhrasePosList: vm.selectedPhrasePosList,
          onSelectPhrase: vm.onSelectPhrase,
          group: vm.group,
          category: vm.category,
          phraseClassifications: vm.phraseClassifications,
          classOrder: vm.classOrder,
          phraseCurrent: vm.phraseCurrent,
          // onUpdateExistCategoryInPos: vm.onUpdateExistCategoryInPos,
          onSetNullSelectedPhraseAndCategory:
              vm.onSetNullSelectedPhraseAndCategory),
    );
  }
}

class LearnPhrasePageFactory
    extends VmFactory<AppState, LearnPhrasePageConnector> {
  LearnPhrasePageFactory(widget) : super(widget);
  @override
  LearnPhrasePageVm fromStore() => LearnPhrasePageVm(
        phraseList: state.learnState.phraseCurrent!.phraseList,
        selectedPhrasePosList: state.classifyingState.selectedPosPhraseList!,
        group: state.classificationState.classificationCurrent!.group,
        category: state.classificationState.classificationCurrent!.category,
        onSelectPhrase: (int phrasePos) {
          dispatch(SetSelectedPhrasePosClassifyingAction(phrasePos: phrasePos));
        },
        phraseClassifications: state.learnState.phraseCurrent!.classifications,
        classOrder: state.learnState.phraseCurrent!.classOrder,

        phraseCurrent: state.learnState.phraseCurrent!,
        // onUpdateExistCategoryInPos: (String groupId) {
        //   dispatch(UpdateExistCategoryInPosLearnPhrasePageAction(groupId: groupId));
        // },
        onSetNullSelectedPhraseAndCategory: () {
          // dispatch(SetNullSelectedCategoryIdLearnPhrasePageAction());
          dispatch(SetNullSelectedPhrasePosClassifyingAction());
        },
      );
}

class LearnPhrasePageVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Function(int) onSelectPhrase;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;

  final PhraseModel phraseCurrent;
  // final Function(String) onUpdateExistCategoryInPos;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  LearnPhrasePageVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.group,
    required this.category,
    required this.onSelectPhrase,
    required this.phraseClassifications,
    required this.classOrder,
    required this.phraseCurrent,
    // required this.onUpdateExistCategoryInPos,
    required this.onSetNullSelectedPhraseAndCategory,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
          group,
          category,
          phraseClassifications,
          classOrder,
          phraseCurrent
        ]);
}
