import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../learn_addedit_page.dart';
import 'learn_action.dart';
import 'learn_model.dart';

class LearnAddEditPageConnector extends StatelessWidget {
  final String addOrEditId;
  const LearnAddEditPageConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, LearnAddEditPageVm>(
      onInit: (store) {
        store.dispatch(SetLearnCurrentLearnAction(id: addOrEditId));
      },
      vm: () => LearnAddEditPageFactory(this),
      builder: (context, vm) => LearnAddEditPage(
        formControllerLearn: vm.formControllerLearn,
        onSave: vm.onSave,
      ),
    );
  }
}

class LearnAddEditPageFactory
    extends VmFactory<AppState, LearnAddEditPageConnector> {
  LearnAddEditPageFactory(widget) : super(widget);
  @override
  LearnAddEditPageVm fromStore() => LearnAddEditPageVm(
        formControllerLearn:
            FormControllerLearn(learnModel: state.learnState.learnCurrent!),
        onSave: (LearnModel learnModel) {
          if (widget!.addOrEditId.isEmpty) {
            dispatch(CreateDocLearnAction(learnModel: learnModel));
          } else {
            dispatch(UpdateDocLearnAction(learnModel: learnModel));
          }
        },
      );
}

class LearnAddEditPageVm extends Vm {
  final FormControllerLearn formControllerLearn;
  final Function(LearnModel) onSave;

  LearnAddEditPageVm({
    required this.formControllerLearn,
    required this.onSave,
  }) : super(equals: [
          formControllerLearn,
        ]);
}

class FormControllerLearn {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  LearnModel learnModel;
  FormControllerLearn({
    required this.learnModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? description,
    bool? isDeleted,
  }) {
    learnModel = learnModel.copyWith(
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
