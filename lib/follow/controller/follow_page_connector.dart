import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../follow_page.dart';
import 'follow_action.dart';
import 'follow_model.dart';

class FollowPageConnector extends StatelessWidget {
  const FollowPageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FollowPageVm>(
      vm: () => FollowPageVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsFollowAction());
      },
      builder: (context, vm) => FollowPage(
        followList: vm.followList,
      ),
    );
  }
}

class FollowPageVmFactory extends VmFactory<AppState, FollowPageConnector> {
  FollowPageVmFactory(widget) : super(widget);
  @override
  FollowPageVm fromStore() => FollowPageVm(
        followList: state.followState.followList!,
      );
}

class FollowPageVm extends Vm {
  final List<FollowModel> followList;
  FollowPageVm({
    required this.followList,
  }) : super(equals: [
          followList,
        ]);
}
