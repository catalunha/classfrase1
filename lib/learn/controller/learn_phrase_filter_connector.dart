import 'package:async_redux/async_redux.dart';
import 'package:classfrase/classification/controller/classification_action.dart';
import 'package:classfrase/classification/controller/classification_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../learn_phrase_filter.dart';
import 'learn_action.dart';

class LearnPhraseFilterConnector extends StatelessWidget {
  final String userId;

  const LearnPhraseFilterConnector({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LearnPhraseListPageVm>(
      vm: () => LearnPhraseListPageVmFactory(this),
      onInit: (store) {
        // store.dispatch(SetUserCurrentLearnAction(id: userId));
        // store.dispatch(GetDocsPhraseLearnAction());
      },
      builder: (context, vm) => LearnPhraseFilter(
        groupList: vm.groupList,
        groupId: vm.groupId,
        categoryList: vm.categoryList,
        onSetGroup: vm.onSetGroup,
        phraseList: vm.phraseList,
        onFilterByThisCategory: vm.onFilterByThisCategory,
      ),
    );
  }
}

class LearnPhraseListPageVmFactory
    extends VmFactory<AppState, LearnPhraseFilterConnector> {
  LearnPhraseListPageVmFactory(widget) : super(widget);
  @override
  LearnPhraseListPageVm fromStore() => LearnPhraseListPageVm(
        groupList: groupListSorted(),
        groupId: state.classificationState.groupCurrent == null
            ? null
            : state.classificationState.groupCurrent!.id,
        categoryList: categoryFilter(),
        onSetGroup: (String groupId) {
          dispatch(SetGroupCurrentClassificationAction(id: groupId));
        },
        phraseList: state.learnState.phraseList!,
        onFilterByThisCategory: (String categoryId) {
          dispatch(FilterByThisCategoryLearnAction(categoryId: categoryId));
        },
      );

  List<ClassGroup> groupListSorted() {
    Map<String, ClassGroup> group =
        state.classificationState.classificationCurrent!.group;
    List<ClassGroup> groupList = group.entries.map((e) => e.value).toList();
    groupList.sort((a, b) => a.title.compareTo(b.title));
    return groupList;
  }

  List<ClassCategory> categoryFilter() {
    ClassGroup? classGroup = state.classificationState.groupCurrent;
    List<ClassCategory> categoryFiltered = [];
    if (classGroup != null) {
      Map<String, ClassCategory> category =
          state.classificationState.classificationCurrent!.category;
      List<ClassCategory> categoryList =
          category.entries.map((e) => e.value).toList();
      categoryFiltered = categoryList
          .where((element) => element.group == classGroup.id)
          .toList();
      categoryFiltered.sort((a, b) => a.title.compareTo(b.title));
    }
    return categoryFiltered;
  }
}

class LearnPhraseListPageVm extends Vm {
  final List<ClassGroup> groupList;
  final String? groupId;
  final Function(String) onSetGroup;
  final List<ClassCategory> categoryList;
  final List<PhraseModel> phraseList;
  final Function(String) onFilterByThisCategory;
  LearnPhraseListPageVm({
    required this.groupList,
    required this.groupId,
    required this.onSetGroup,
    required this.categoryList,
    required this.phraseList,
    required this.onFilterByThisCategory,
  }) : super(equals: [
          groupList,
          groupId,
          categoryList,
          phraseList,
        ]);
}
