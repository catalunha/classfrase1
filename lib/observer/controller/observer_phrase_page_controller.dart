import 'package:async_redux/async_redux.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../observer_phrase_page.dart';
import 'observer_action.dart';

class ObserverPhrasePageConnector extends StatelessWidget {
  final String observerId;

  const ObserverPhrasePageConnector({Key? key, required this.observerId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ObserverPhrasePageVm>(
      vm: () => ObserverPhrasePageVmFactory(this),
      onInit: (store) {
        store.dispatch(SetObserverCurrentObserverAction(id: observerId));
        store.dispatch(StreamDocsPhraseObserverAction());
      },
      builder: (context, vm) => ObserverPhrasePage(
        observerPhraseList: vm.observerPhraseList,
      ),
    );
  }
}

class ObserverPhrasePageVmFactory
    extends VmFactory<AppState, ObserverPhrasePageConnector> {
  ObserverPhrasePageVmFactory(widget) : super(widget);
  @override
  ObserverPhrasePageVm fromStore() => ObserverPhrasePageVm(
        observerPhraseList: state.observerState.observerPhraseList!,
      );
}

class ObserverPhrasePageVm extends Vm {
  final List<PhraseModel> observerPhraseList;
  ObserverPhrasePageVm({
    required this.observerPhraseList,
  }) : super(equals: [
          observerPhraseList,
        ]);
}
