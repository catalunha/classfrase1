import 'package:async_redux/async_redux.dart';
import 'package:classfrase/follow/controller/follow_model.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../following_users_page.dart';
import 'follow_action.dart';

class FollowingUsersPageConnector extends StatelessWidget {
  final String followId;

  const FollowingUsersPageConnector({Key? key, required this.followId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FollowingUsersPageVm>(
      vm: () => FollowingUsersPageVmFactory(this),
      onInit: (store) {
        store.dispatch(SetFollowCurrentFollowAction(id: followId));
      },
      builder: (context, vm) => FollowingUsersPage(
        follow: vm.follow,
        following: vm.following,
        userDelete: vm.userDelete,
      ),
    );
  }
}

class FollowingUsersPageVmFactory
    extends VmFactory<AppState, FollowingUsersPageConnector> {
  FollowingUsersPageVmFactory(widget) : super(widget);
  @override
  FollowingUsersPageVm fromStore() => FollowingUsersPageVm(
        follow: state.followState.followCurrent!,
        following: state.followState.followCurrent!.following,
        userDelete: (String userId) {
          dispatch(DeleteFollowingUserFollowAction(userId: userId));
        },
      );
}

class FollowingUsersPageVm extends Vm {
  final FollowModel follow;
  final Map<String, UserRef> following;
  final Function(String) userDelete;
  FollowingUsersPageVm({
    required this.follow,
    required this.following,
    required this.userDelete,
  }) : super(equals: [
          following,
        ]);
}
