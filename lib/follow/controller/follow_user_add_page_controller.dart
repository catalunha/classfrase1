import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../follow_addedit_page.dart';
import '../follow_user_add_page.dart';
import 'follow_action.dart';
import 'follow_model.dart';

class FollowUserAddPageConnector extends StatelessWidget {
  const FollowUserAddPageConnector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, FollowUserAddPageVm>(
      // onInit: (store) {
      //   store.dispatch(SetFollowCurrentFollowAction(id: addOrEditId));
      // },
      vm: () => FollowUserAddPageFactory(this),
      builder: (context, vm) => FollowUserAddPage(
        formControllerFollowUserAdd: vm.formControllerFollowUserAdd,
        onSave: vm.onSave,
      ),
    );
  }
}

class FollowUserAddPageFactory
    extends VmFactory<AppState, FollowUserAddPageConnector> {
  FollowUserAddPageFactory(widget) : super(widget);
  @override
  FollowUserAddPageVm fromStore() => FollowUserAddPageVm(
        formControllerFollowUserAdd: FormControllerFollowUserAdd(email: ''),
        onSave: (String email) {
          dispatch(SearchingEmailFollowAction(email: email));
        },
      );
}

class FollowUserAddPageVm extends Vm {
  final FormControllerFollowUserAdd formControllerFollowUserAdd;
  final Function(String) onSave;

  FollowUserAddPageVm({
    required this.formControllerFollowUserAdd,
    required this.onSave,
  }) : super(equals: [
          formControllerFollowUserAdd,
        ]);
}

class FormControllerFollowUserAdd {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  String email;
  FormControllerFollowUserAdd({
    required this.email,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? email,
  }) {
    this.email = email ?? this.email;
  }

  void onCheckValidation() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
