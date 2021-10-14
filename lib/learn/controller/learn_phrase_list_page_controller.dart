import 'package:async_redux/async_redux.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../learn_phrase_list_page.dart';
import 'learn_action.dart';

class LearnPhraseListPageConnector extends StatelessWidget {
  final String userId;

  const LearnPhraseListPageConnector({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LearnPhraseListPageVm>(
      vm: () => LearnPhraseListPageVmFactory(this),
      onInit: (store) {
        store.dispatch(SetUserCurrentLearnAction(id: userId));
        store.dispatch(GetDocsPhraseLearnAction());
      },
      builder: (context, vm) => LearnPhraseListPage(
        phraseList: vm.phraseList,
        userRefCurrent: vm.userRefCurrent,
      ),
    );
  }
}

class LearnPhraseListPageVmFactory
    extends VmFactory<AppState, LearnPhraseListPageConnector> {
  LearnPhraseListPageVmFactory(widget) : super(widget);
  @override
  LearnPhraseListPageVm fromStore() => LearnPhraseListPageVm(
        phraseList: state.learnState.phraseList!,
        userRefCurrent: state.learnState.userRefCurrent!,
      );
}

class LearnPhraseListPageVm extends Vm {
  final UserRef userRefCurrent;

  final List<PhraseModel> phraseList;
  LearnPhraseListPageVm({
    required this.phraseList,
    required this.userRefCurrent,
  }) : super(equals: [
          userRefCurrent,
          phraseList,
        ]);
}
