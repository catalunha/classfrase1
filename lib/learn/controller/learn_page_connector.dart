import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../learn_page.dart';
import 'learn_action.dart';
import 'learn_model.dart';

class LearnPageConnector extends StatelessWidget {
  const LearnPageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LearnPageVm>(
      vm: () => LearnPageVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsLearnAction());
      },
      builder: (context, vm) => LearnPage(
        learnList: vm.learnList,
      ),
    );
  }
}

class LearnPageVmFactory extends VmFactory<AppState, LearnPageConnector> {
  LearnPageVmFactory(widget) : super(widget);
  @override
  LearnPageVm fromStore() => LearnPageVm(
        learnList: state.learnState.learnList!,
      );
}

class LearnPageVm extends Vm {
  final List<LearnModel> learnList;
  LearnPageVm({
    required this.learnList,
  }) : super(equals: [
          learnList,
        ]);
}
