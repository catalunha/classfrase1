import 'package:async_redux/async_redux.dart';
import 'package:classfrase/learn/controller/learn_model.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../learning_users_page.dart';
import 'learn_action.dart';

class LearningUsersPageConnector extends StatelessWidget {
  final String learnId;

  const LearningUsersPageConnector({Key? key, required this.learnId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LearningUsersPageVm>(
      vm: () => LearningUsersPageVmFactory(this),
      onInit: (store) {
        store.dispatch(SetLearnCurrentLearnAction(id: learnId));
      },
      builder: (context, vm) => LearningUsersPage(
        learn: vm.learn,
        learningList: vm.learningList,
        onUserDelete: vm.onUserDelete,
        onSetUserGetPhrases: vm.onSetUserGetPhrases,
      ),
    );
  }
}

class LearningUsersPageVmFactory
    extends VmFactory<AppState, LearningUsersPageConnector> {
  LearningUsersPageVmFactory(widget) : super(widget);
  @override
  LearningUsersPageVm fromStore() => LearningUsersPageVm(
        learn: state.learnState.learnCurrent!,
        learningList: learningSorted(),
        onUserDelete: (String userId) {
          dispatch(DeleteLearningUserLearnAction(userId: userId));
        },
        onSetUserGetPhrases: (String userId) {
          dispatch(SetUserCurrentLearnAction(id: userId));
          dispatch(GetDocsPhraseLearnAction());
        },
      );

  List<UserRef> learningSorted() {
    Map<String, UserRef> learning = state.learnState.learnCurrent!.learning;
    List<UserRef> userRefSorted = learning.entries.map((e) => e.value).toList();
    userRefSorted.sort((a, b) => a.displayName!.compareTo(b.displayName!));
    return userRefSorted;
  }
}

class LearningUsersPageVm extends Vm {
  final LearnModel learn;
  final List<UserRef> learningList;
  final Function(String) onUserDelete;
  final Function(String) onSetUserGetPhrases;
  LearningUsersPageVm({
    required this.learn,
    required this.learningList,
    required this.onUserDelete,
    required this.onSetUserGetPhrases,
  }) : super(equals: [
          learn,
          learningList,
        ]);
}
