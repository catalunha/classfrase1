import 'package:async_redux/async_redux.dart';
import 'package:classfrase/app_state.dart';
import 'package:classfrase/phrase/controller/phrase_action.dart';
import 'package:flutter/material.dart';

import '../classifying_page.dart';
import 'classifying_action.dart';

class ClassifyingConnector extends StatelessWidget {
  final String phraseId;

  const ClassifyingConnector({
    Key? key,
    required this.phraseId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ClassifyingVm>(
      onInit: (store) {
        store.dispatch(SetPhraseCurrentPhraseAction(id: phraseId));
        store.dispatch(SetPhraseListClassifyingAction());
      },
      vm: () => ClassifyingFactory(this),
      builder: (context, vm) => ClassifyingPage(
        phraseList: vm.phraseList,
        selectedPhrasePosList: vm.selectedPhrasePosList,
        setPhraseSelected: vm.setPhraseSelected,
      ),
    );
  }
}

class ClassifyingFactory extends VmFactory<AppState, ClassifyingConnector> {
  ClassifyingFactory(widget) : super(widget);
  @override
  ClassifyingVm fromStore() => ClassifyingVm(
        phraseList: state.classifyingState.phraseList!,
        selectedPhrasePosList: state.classifyingState.selectedPhrasePosList!,
        setPhraseSelected: (int phrasePos) {
          dispatch(SetSelectedPhrasePosClassifyingAction(phrasePos: phrasePos));
        },
      );
}

class ClassifyingVm extends Vm {
  final List<String> phraseList;
  final List<int> selectedPhrasePosList;
  final Function(int) setPhraseSelected;
  ClassifyingVm({
    required this.phraseList,
    required this.selectedPhrasePosList,
    required this.setPhraseSelected,
  }) : super(equals: [
          phraseList,
          selectedPhrasePosList,
        ]);
}
