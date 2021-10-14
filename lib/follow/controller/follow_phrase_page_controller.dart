import 'package:async_redux/async_redux.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/classifying/controller/classifying_action.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../follow_phrase_page.dart';
import 'follow_action.dart';

class FollowPhrasePageConnector extends StatelessWidget {
  final String phraseId;

  const FollowPhrasePageConnector({
    Key? key,
    required this.phraseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FollowPhrasePageVm>(
      onInit: (store) {
        store.dispatch(SetPhraseCurrentFollowAction(id: phraseId));
      },
      vm: () => FollowPhrasePageFactory(this),
      builder: (context, vm) => FollowPhrasePage(
          phraseList: vm.phraseList,
          selectedPhrasePosList: vm.selectedPhrasePosList,
          onSelectPhrase: vm.onSelectPhrase,
          group: vm.group,
          category: vm.category,
          phraseClassifications: vm.phraseClassifications,
          phraseCurrent: vm.phraseCurrent,
          // onUpdateExistCategoryInPos: vm.onUpdateExistCategoryInPos,
          onSetNullSelectedPhraseAndCategory:
              vm.onSetNullSelectedPhraseAndCategory),
    );
  }
}

class FollowPhrasePageFactory
    extends VmFactory<AppState, FollowPhrasePageConnector> {
  FollowPhrasePageFactory(widget) : super(widget);
  @override
  FollowPhrasePageVm fromStore() => FollowPhrasePageVm(
        phraseList: state.followState.phraseCurrent!.phraseList,
        selectedPhrasePosList: state.classifyingState.selectedPosPhraseList!,
        group: state.classificationState.classificationCurrent!.group,
        category: state.classificationState.classificationCurrent!.category,
        onSelectPhrase: (int phrasePos) {
          dispatch(SetSelectedPhrasePosClassifyingAction(phrasePos: phrasePos));
        },
        phraseClassifications: state.followState.phraseCurrent!.classifications,
        phraseCurrent: state.followState.phraseCurrent!,
        // onUpdateExistCategoryInPos: (String groupId) {
        //   dispatch(UpdateExistCategoryInPosFollowPhrasePageAction(groupId: groupId));
        // },
        onSetNullSelectedPhraseAndCategory: () {
          // dispatch(SetNullSelectedCategoryIdFollowPhrasePageAction());
          dispatch(SetNullSelectedPhrasePosClassifyingAction());
        },
      );
}

class FollowPhrasePageVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Function(int) onSelectPhrase;
  final Map<String, ClassGroup> group;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final PhraseModel phraseCurrent;
  // final Function(String) onUpdateExistCategoryInPos;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  FollowPhrasePageVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.group,
    required this.category,
    required this.onSelectPhrase,
    required this.phraseClassifications,
    required this.phraseCurrent,
    // required this.onUpdateExistCategoryInPos,
    required this.onSetNullSelectedPhraseAndCategory,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
          group,
          category,
          phraseClassifications,
          phraseCurrent
        ]);
}
