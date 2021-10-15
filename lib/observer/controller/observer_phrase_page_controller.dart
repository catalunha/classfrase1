import 'package:async_redux/async_redux.dart';
import 'package:classfrase/phrase/controller/phrase_action.dart';
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
        setNullObserverFieldPhrase: vm.setNullObserverFieldPhrase,
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
        setNullObserverFieldPhrase: (String phraseId) {
          dispatch(
              SetNullObserverFieldPhraseObserverAction(phraseId: phraseId));
        },
      );
}

class ObserverPhrasePageVm extends Vm {
  final List<PhraseModel> observerPhraseList;
  final Function(String) setNullObserverFieldPhrase;
  ObserverPhrasePageVm({
    required this.observerPhraseList,
    required this.setNullObserverFieldPhrase,
  }) : super(equals: [
          observerPhraseList,
        ]);
}
