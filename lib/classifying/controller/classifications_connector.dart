import 'package:async_redux/async_redux.dart';
import 'package:classfrase/app_state.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:flutter/material.dart';

import '../classifications_page.dart';
import 'classifying_action.dart';

class ClassificationsConnector extends StatelessWidget {
  final String groupId;

  const ClassificationsConnector({Key? key, required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClassificationsVm>(
      vm: () => ClassificationsFactory(this),
      builder: (context, vm) => ClassificationsPage(
        phraseList: vm.phraseList,
        selectedPhrasePosList: vm.selectedPhrasePosList,
        groupId: vm.groupId,
        groupData: vm.groupData,
        category: vm.category,
        onSelectCategory: vm.onSelectCategory,
        selectedCategoryIdList: vm.selectedCategoryIdList,
        onSaveClassification: vm.onSaveClassification,
        onSetNullSelectedCategoryIdOld: vm.onSetNullSelectedCategoryIdOld,
      ),
    );
  }
}

class ClassificationsFactory
    extends VmFactory<AppState, ClassificationsConnector> {
  ClassificationsFactory(widget) : super(widget);
  @override
  ClassificationsVm fromStore() => ClassificationsVm(
        phraseList: state.classifyingState.phraseList!,
        selectedPhrasePosList: state.classifyingState.selectedPosPhraseList!,
        groupId: widget!.groupId,
        groupData:
            state.classifyingState.classificationModel!.group[widget!.groupId]!,
        category: categoryFilter(),
        onSelectCategory: (String categoryId) {
          dispatch(
              SetSelectedCategoryIdClassifyingAction(categoryId: categoryId));
        },
        selectedCategoryIdList: state.classifyingState.selectedCategoryIdList!,
        onSaveClassification: () {
          dispatch(UpdateClassificationClassifyingAction());
        },
        onSetNullSelectedCategoryIdOld: () {
          dispatch(SetNullSelectedCategoryIdClassifyingAction());
        },
      );

  categoryFilter() {
    var categoryTemp = <String, ClassCategory>{};
    for (var category
        in state.classifyingState.classificationModel!.category.entries) {
      if (category.value.type == widget!.groupId) {
        categoryTemp.addAll({category.key: category.value});
      }
    }
    return categoryTemp;
  }
}

class ClassificationsVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final String groupId;
  final ClassGroup groupData;
  final Map<String, ClassCategory> category;
  final Function(String) onSelectCategory;
  final List<String> selectedCategoryIdList;
  final VoidCallback onSaveClassification;
  final VoidCallback onSetNullSelectedCategoryIdOld;
  ClassificationsVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.groupId,
    required this.groupData,
    required this.category,
    required this.onSelectCategory,
    required this.selectedCategoryIdList,
    required this.onSaveClassification,
    required this.onSetNullSelectedCategoryIdOld,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
          groupId,
          groupData,
          category,
          selectedCategoryIdList
        ]);
}
