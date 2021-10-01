import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../observer_addedit_page.dart';
import 'observer_action.dart';
import 'observer_model.dart';

class ObserverAddEditPageConnector extends StatelessWidget {
  final String addOrEditId;
  const ObserverAddEditPageConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ObserverAddEditPageVm>(
      onInit: (store) {
        store.dispatch(SetObserverCurrentObserverAction(id: addOrEditId));
      },
      vm: () => ObserverAddEditPageFactory(this),
      builder: (context, vm) => ObserverAddEditPage(
        formControllerObserver: vm.formControllerObserver,
        onSave: vm.onSave,
      ),
    );
  }
}

class ObserverAddEditPageFactory
    extends VmFactory<AppState, ObserverAddEditPageConnector> {
  ObserverAddEditPageFactory(widget) : super(widget);
  @override
  ObserverAddEditPageVm fromStore() => ObserverAddEditPageVm(
        formControllerObserver: FormControllerObserver(
            observerModel: state.observerState.observerCurrent!),
        onSave: (ObserverModel observerModel) {
          if (widget!.addOrEditId.isEmpty) {
            dispatch(CreateDocObserverAction(observerModel: observerModel));
          } else {
            dispatch(UpdateDocObserverAction(observerModel: observerModel));
          }
        },
      );
}

class ObserverAddEditPageVm extends Vm {
  final FormControllerObserver formControllerObserver;
  final Function(ObserverModel) onSave;

  ObserverAddEditPageVm({
    required this.formControllerObserver,
    required this.onSave,
  }) : super(equals: [
          formControllerObserver,
        ]);
}

class FormControllerObserver {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  ObserverModel observerModel;
  FormControllerObserver({
    required this.observerModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? description,
    bool? isDeleted,
  }) {
    observerModel = observerModel.copyWith(
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
