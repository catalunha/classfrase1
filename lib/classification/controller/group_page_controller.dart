import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../group_page.dart';
import 'classification_action.dart';
import 'classification_model.dart';

class GroupPageConnector extends StatelessWidget {
  const GroupPageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupPageVm>(
      vm: () => GroupPageVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsClassificationAction());
      },
      builder: (context, vm) => GroupPage(
        group: vm.group,
      ),
    );
  }
}

class GroupPageVmFactory extends VmFactory<AppState, GroupPageConnector> {
  GroupPageVmFactory(widget) : super(widget);
  @override
  GroupPageVm fromStore() => GroupPageVm(
        group: state.classificationState.classificationCurrent!.group,
      );
}

class GroupPageVm extends Vm {
  final Map<String, ClassGroup> group;
  GroupPageVm({
    required this.group,
  }) : super(equals: [
          group,
        ]);
}
