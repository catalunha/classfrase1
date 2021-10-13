import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../follow_addedit_page.dart';
import 'follow_action.dart';
import 'follow_model.dart';

class FollowAddEditPageConnector extends StatelessWidget {
  final String addOrEditId;
  const FollowAddEditPageConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FollowAddEditPageVm>(
      onInit: (store) {
        store.dispatch(SetFollowCurrentFollowAction(id: addOrEditId));
      },
      vm: () => FollowAddEditPageFactory(this),
      builder: (context, vm) => FollowAddEditPage(
        formControllerFollow: vm.formControllerFollow,
        onSave: vm.onSave,
      ),
    );
  }
}

class FollowAddEditPageFactory
    extends VmFactory<AppState, FollowAddEditPageConnector> {
  FollowAddEditPageFactory(widget) : super(widget);
  @override
  FollowAddEditPageVm fromStore() => FollowAddEditPageVm(
        formControllerFollow:
            FormControllerFollow(followModel: state.followState.followCurrent!),
        onSave: (FollowModel followModel) {
          if (widget!.addOrEditId.isEmpty) {
            dispatch(CreateDocFollowAction(followModel: followModel));
          } else {
            dispatch(UpdateDocFollowAction(followModel: followModel));
          }
        },
      );
}

class FollowAddEditPageVm extends Vm {
  final FormControllerFollow formControllerFollow;
  final Function(FollowModel) onSave;

  FollowAddEditPageVm({
    required this.formControllerFollow,
    required this.onSave,
  }) : super(equals: [
          formControllerFollow,
        ]);
}

class FormControllerFollow {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  FollowModel followModel;
  FormControllerFollow({
    required this.followModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? description,
    bool? isDeleted,
  }) {
    followModel = followModel.copyWith(
      description: description,
      isDeleted: isDeleted,
    );
  }

  void onCheckValidation() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
