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
        learning: vm.learning,
        userDelete: vm.userDelete,
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
        learning: state.learnState.learnCurrent!.learning,
        userDelete: (String userId) {
          dispatch(DeleteLearningUserLearnAction(userId: userId));
        },
      );
}

class LearningUsersPageVm extends Vm {
  final LearnModel learn;
  final Map<String, UserRef> learning;
  final Function(String) userDelete;
  LearningUsersPageVm({
    required this.learn,
    required this.learning,
    required this.userDelete,
  }) : super(equals: [
          learning,
        ]);
}
