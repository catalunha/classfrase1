import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../group_addedit_page.dart';
import 'classification_action.dart';
import 'classification_model.dart';

class GroupAddEditPageConnector extends StatelessWidget {
  final String addOrEditId;
  const GroupAddEditPageConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, GroupAddEditPageVm>(
      onInit: (store) {
        store.dispatch(SetGroupCurrentClassificationAction(id: addOrEditId));
      },
      vm: () => GroupAddEditPageFactory(this),
      builder: (context, vm) => GroupAddEditPage(
        formControllerGroup: vm.formControllerGroup,
        onSave: vm.onSave,
      ),
    );
  }
}

class GroupAddEditPageFactory
    extends VmFactory<AppState, GroupAddEditPageConnector> {
  GroupAddEditPageFactory(widget) : super(widget);
  @override
  GroupAddEditPageVm fromStore() => GroupAddEditPageVm(
        formControllerGroup:
            FormControllerGroup(group: state.classificationState.groupCurrent!),
        onSave: (ClassGroup group) {
          dispatch(UpdateDocGroupClassificationAction(classGroup: group));
        },
      );
}

class GroupAddEditPageVm extends Vm {
  final FormControllerGroup formControllerGroup;
  final Function(ClassGroup) onSave;

  GroupAddEditPageVm({
    required this.formControllerGroup,
    required this.onSave,
  }) : super(equals: [
          formControllerGroup,
        ]);
}

class FormControllerGroup {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  ClassGroup group;
  FormControllerGroup({
    required this.group,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? title,
    String? url,
  }) {
    group = group.copyWith(
      title: title,
      url: url,
    );
  }

  void onCheckValidation() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
