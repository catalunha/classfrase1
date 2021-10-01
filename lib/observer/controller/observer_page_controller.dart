import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../observer_page.dart';
import 'observer_action.dart';
import 'observer_model.dart';

class ObserverPageConnector extends StatelessWidget {
  const ObserverPageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ObserverPageVm>(
      vm: () => ObserverPageVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsObserverAction());
      },
      builder: (context, vm) => ObserverPage(
        observerList: vm.observerList,
      ),
    );
  }
}

class ObserverPageVmFactory extends VmFactory<AppState, ObserverPageConnector> {
  ObserverPageVmFactory(widget) : super(widget);
  @override
  ObserverPageVm fromStore() => ObserverPageVm(
        observerList: state.observerState.observerList!,
      );
}

class ObserverPageVm extends Vm {
  final List<ObserverModel> observerList;
  ObserverPageVm({
    required this.observerList,
  }) : super(equals: [
          observerList,
        ]);
}
