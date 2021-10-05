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
        category: state.classificationState.classificationCurrent!.category,
        groupCurrent: state.classificationState.groupCurrent!,
      );
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
