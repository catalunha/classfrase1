import 'dart:collection';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../category_page.dart';
import 'classification_action.dart';
import 'classification_model.dart';

class CategoryPageConnector extends StatelessWidget {
  final String groupId;
  const CategoryPageConnector({Key? key, required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CategoryPageVm>(
      vm: () => CategoryPageVmFactory(this),
      onInit: (store) {
        store.dispatch(SetGroupCurrentClassificationAction(id: groupId));
      },
      builder: (context, vm) => CategoryPage(
        category: vm.category,
        groupCurrent: vm.groupCurrent,
      ),
    );
  }
}

class CategoryPageVmFactory extends VmFactory<AppState, CategoryPageConnector> {
  CategoryPageVmFactory(widget) : super(widget);
  @override
  CategoryPageVm fromStore() => CategoryPageVm(
        category: categoryFilter(),
        groupCurrent: state.classificationState.groupCurrent!,
      );

  Map<String, ClassCategory> categoryFilter() {
    Map<String, ClassCategory> category =
        state.classificationState.classificationCurrent!.category;
    Map<String, ClassCategory> categorySorted = SplayTreeMap.from(category,
        (key1, key2) => category[key1]!.title.compareTo(category[key2]!.title));

    Map<String, ClassCategory> temp = <String, ClassCategory>{};
    for (var item in categorySorted.entries) {
      if (item.value.group == widget!.groupId) {
        temp[item.key] = item.value;
      }
    }
    return temp;
  }
}

class CategoryPageVm extends Vm {
  final Map<String, ClassCategory> category;
  final ClassGroup groupCurrent;
  CategoryPageVm({
    required this.category,
    required this.groupCurrent,
  }) : super(equals: [
          category,
          groupCurrent,
        ]);
}
