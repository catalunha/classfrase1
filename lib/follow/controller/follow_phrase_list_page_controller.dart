import 'package:async_redux/async_redux.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../follow_phrase_list_page.dart';
import 'follow_action.dart';

class FollowPhraseListPageConnector extends StatelessWidget {
  final String userId;

  const FollowPhraseListPageConnector({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FollowPhraseListPageVm>(
      vm: () => FollowPhraseListPageVmFactory(this),
      onInit: (store) {
        store.dispatch(SetUserCurrentFollowAction(id: userId));
        store.dispatch(GetDocsPhraseFollowAction());
      },
      builder: (context, vm) => FollowPhraseListPage(
        phraseList: vm.phraseList,
        userRefCurrent: vm.userRefCurrent,
      ),
    );
  }
}

class FollowPhraseListPageVmFactory
    extends VmFactory<AppState, FollowPhraseListPageConnector> {
  FollowPhraseListPageVmFactory(widget) : super(widget);
  @override
  FollowPhraseListPageVm fromStore() => FollowPhraseListPageVm(
        phraseList: state.followState.phraseList!,
        userRefCurrent: state.followState.userRefCurrent!,
      );
}

class FollowPhraseListPageVm extends Vm {
  final UserRef userRefCurrent;

  final List<PhraseModel> phraseList;
  FollowPhraseListPageVm({
    required this.phraseList,
    required this.userRefCurrent,
  }) : super(equals: [
          userRefCurrent,
          phraseList,
        ]);
}
