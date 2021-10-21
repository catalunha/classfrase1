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
        categoryList: vm.categoryList,
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
        phraseList: state.phraseState.phraseCurrent!.phraseList,
        selectedPhrasePosList: state.classifyingState.selectedPosPhraseList!,
        groupId: widget!.groupId,
        groupData: state
            .classificationState.classificationCurrent!.group[widget!.groupId]!,
        categoryList: categoryFilter(),
        onSelectCategory: (String categoryId) {
          dispatch(
              SetSelectedCategoryIdClassifyingAction(categoryId: categoryId));
        },
        selectedCategoryIdList: state.classifyingState.selectedCategoryIdList!,
        onSaveClassification: () {
          dispatch(UpdateClassificationsPhraseClassifyingAction());
        },
        onSetNullSelectedCategoryIdOld: () {
          dispatch(SetNullSelectedCategoryIdClassifyingAction());
        },
      );

  List<ClassCategory> categoryFilter() {
    Map<String, ClassCategory> category =
        state.classificationState.classificationCurrent!.category;
    List<ClassCategory> categoryList =
        category.entries.map((e) => e.value).toList();
    List<ClassCategory> categoryFiltered = categoryList
        .where((element) => element.group == widget!.groupId)
        .toList();
    categoryFiltered.sort((a, b) => a.title.compareTo(b.title));

    return categoryFiltered;
  }
}

class ClassificationsVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final String groupId;
  final ClassGroup groupData;
  final List<ClassCategory> categoryList;
  final Function(String) onSelectCategory;
  final List<String> selectedCategoryIdList;
  final VoidCallback onSaveClassification;
  final VoidCallback onSetNullSelectedCategoryIdOld;
  ClassificationsVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.groupId,
    required this.groupData,
    required this.categoryList,
    required this.onSelectCategory,
    required this.selectedCategoryIdList,
    required this.onSaveClassification,
    required this.onSetNullSelectedCategoryIdOld,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
          groupId,
          groupData,
          categoryList,
          selectedCategoryIdList
        ]);
}
