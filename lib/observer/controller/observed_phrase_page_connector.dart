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
      },
      vm: () => ObservedPhrasePageFactory(this),
      builder: (context, vm) => ObservedPhrasePage(
          phraseList: vm.phraseList,
          selectedPhrasePosList: vm.selectedPhrasePosList,
          onSelectPhrase: vm.onSelectPhrase,
          groupList: vm.groupList,
          category: vm.category,
          phraseClassifications: vm.phraseClassifications,
          classOrder: vm.classOrder,
          observerPhraseCurrent: vm.observerPhraseCurrent,
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
        phraseList: state.observerState.observerPhraseCurrent!.phraseList,
        selectedPhrasePosList: state.classifyingState.selectedPosPhraseList!,
        groupList: groupListSorted(),
        category: state.classificationState.classificationCurrent!.category,
        onSelectPhrase: (int phrasePos) {
          dispatch(SetSelectedPhrasePosClassifyingAction(phrasePos: phrasePos));
        },
        phraseClassifications:
            state.observerState.observerPhraseCurrent!.classifications,
        classOrder: state.observerState.observerPhraseCurrent!.classOrder,
        observerPhraseCurrent: state.observerState.observerPhraseCurrent!,
        onSetNullSelectedPhraseAndCategory: () {
          dispatch(SetNullSelectedPhrasePosClassifyingAction());
        },
      );
  List<ClassGroup> groupListSorted() {
    Map<String, ClassGroup> group =
        state.classificationState.classificationCurrent!.group;
    List<ClassGroup> groupList = group.entries.map((e) => e.value).toList();
    groupList.sort((a, b) => a.title.compareTo(b.title));
    return groupList;
  }
}

class ObservedPhrasePageVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Function(int) onSelectPhrase;
  final List<ClassGroup> groupList;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;

  final PhraseModel observerPhraseCurrent;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  ObservedPhrasePageVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.groupList,
    required this.category,
    required this.onSelectPhrase,
    required this.phraseClassifications,
    required this.classOrder,
    required this.observerPhraseCurrent,
    required this.onSetNullSelectedPhraseAndCategory,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
          groupList,
          category,
          phraseClassifications,
          classOrder,
          observerPhraseCurrent
        ]);
}
