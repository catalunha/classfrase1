import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../learn_addedit_page.dart';
import '../learn_user_add_page.dart';
import 'learn_action.dart';
import 'learn_model.dart';

class LearnUserAddPageConnector extends StatelessWidget {
  const LearnUserAddPageConnector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LearnUserAddPageVm>(
      // onInit: (store) {
      //   store.dispatch(SetLearnCurrentLearnAction(id: addOrEditId));
      // },
      vm: () => LearnUserAddPageFactory(this),
      builder: (context, vm) => LearnUserAddPage(
        formControllerLearnUserAdd: vm.formControllerLearnUserAdd,
        onSave: vm.onSave,
      ),
    );
  }
}

class LearnUserAddPageFactory
    extends VmFactory<AppState, LearnUserAddPageConnector> {
  LearnUserAddPageFactory(widget) : super(widget);
  @override
  LearnUserAddPageVm fromStore() => LearnUserAddPageVm(
        formControllerLearnUserAdd: FormControllerLearnUserAdd(email: ''),
        onSave: (String email) {
          dispatch(SearchingEmailLearnAction(email: email));
        },
      );
}

class LearnUserAddPageVm extends Vm {
  final FormControllerLearnUserAdd formControllerLearnUserAdd;
  final Function(String) onSave;

  LearnUserAddPageVm({
    required this.formControllerLearnUserAdd,
    required this.onSave,
  }) : super(equals: [
          formControllerLearnUserAdd,
        ]);
}

class FormControllerLearnUserAdd {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  String email;
  FormControllerLearnUserAdd({
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
