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
        onSelectAllPhrase: vm.onSelectAllPhrase,
        groupList: vm.groupList,
        category: vm.category,
        phraseClassifications: vm.phraseClassifications,
        classOrder: vm.classOrder,
        onChangeClassOrder: vm.onChangeClassOrder,
        onUpdateExistCategoryInPos: vm.onUpdateExistCategoryInPos,
        onSetNullSelectedPhraseAndCategory:
            vm.onSetNullSelectedPhraseAndCategory,
      ),
    );
  }
}

class ClassifyingFactory extends VmFactory<AppState, ClassifyingConnector> {
  ClassifyingFactory(widget) : super(widget);
  @override
  ClassifyingVm fromStore() => ClassifyingVm(
        phraseList: state.phraseState.phraseCurrent!.phraseList,
        selectedPhrasePosList: state.classifyingState.selectedPosPhraseList!,
        groupList: groupListSorted(),
        // group: state.classificationState.classificationCurrent!.group,
        category: state.classificationState.classificationCurrent!.category,
        onSelectPhrase: (int phrasePos) {
          dispatch(SetSelectedPhrasePosClassifyingAction(phrasePos: phrasePos));
        },
        onSelectAllPhrase: (bool? option) {
          if (option == true) {
            dispatch(SetSelectedAllPhrasePosClassifyingAction());
          }
          if (option == false) {
            dispatch(SetSelectedNonePhrasePosClassifyingAction());
          }
          if (option == null) {
            dispatch(SetSelectedInversePhrasePosClassifyingAction());
          }
        },
        phraseClassifications: state.phraseState.phraseCurrent!.classifications,
        classOrder: state.phraseState.phraseCurrent!.classOrder,
        onChangeClassOrder: (List<String> classOrder) {
          // PhraseModel phraseModel = state.phraseState.phraseCurrent!;
          // phraseModel = phraseModel.copyWith(classOrder: classOrder);
          dispatch(UpdateClassOrderPhraseAction(classOrder: classOrder));
        },
        onUpdateExistCategoryInPos: (String groupId) {
          dispatch(UpdateExistCategoryInPosClassifyingAction(groupId: groupId));
        },
        onSetNullSelectedPhraseAndCategory: () {
          dispatch(SetNullSelectedCategoryIdClassifyingAction());
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

class ClassifyingVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Function(int) onSelectPhrase;
  final Function(bool?) onSelectAllPhrase;
  final List<ClassGroup> groupList;
  final Map<String, ClassCategory> category;
  final Map<String, Classification> phraseClassifications;
  final List<String> classOrder;
  final Function(List<String>) onChangeClassOrder;

  final Function(String) onUpdateExistCategoryInPos;
  final VoidCallback onSetNullSelectedPhraseAndCategory;

  ClassifyingVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.groupList,
    required this.category,
    required this.onSelectPhrase,
    required this.onSelectAllPhrase,
    required this.phraseClassifications,
    required this.classOrder,
    required this.onChangeClassOrder,
    required this.onUpdateExistCategoryInPos,
    required this.onSetNullSelectedPhraseAndCategory,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
          groupList,
          category,
          phraseClassifications,
          classOrder,
        ]);
}
