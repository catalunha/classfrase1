import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import 'package:classfrase/app_state.dart';

import '../phrase_addedit_page.dart';
import 'phrase_action.dart';
import 'phrase_model.dart';

class PhraseAddEditConnector extends StatelessWidget {
  final String addOrEditId;
  const PhraseAddEditConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PhraseAddEditVm>(
      onInit: (store) {
        store.dispatch(SetPhraseCurrentPhraseAction(id: addOrEditId));
      },
      vm: () => PhraseAddEditFactory(this),
      builder: (context, vm) => PhraseAddEditPage(
        formController: vm.formController,
        onSave: vm.onSave,
      ),
    );
  }
}

class PhraseAddEditFactory extends VmFactory<AppState, PhraseAddEditConnector> {
  PhraseAddEditFactory(widget) : super(widget);
  @override
  PhraseAddEditVm fromStore() => PhraseAddEditVm(
        formController:
            FormController(phraseModel: state.phraseState.phraseCurrent!),
        onSave: (PhraseModel phraseModel) async {
          if (widget!.addOrEditId.isEmpty) {
            dispatch(CreateDocPhraseAction(phraseModel: phraseModel));
          } else {
            await dispatch(UpdateDocPhraseAction(phraseModel: phraseModel));
          }
        },
      );
}

class PhraseAddEditVm extends Vm {
  final FormController formController;
  final Function(PhraseModel) onSave;

  PhraseAddEditVm({
    required this.formController,
    required this.onSave,
  }) : super(equals: [
          formController,
        ]);
}

class FormController {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  PhraseModel phraseModel;
  FormController({
    required this.phraseModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? phrase,
    String? font,
    String? description,
    String? observer,
    bool? isArchived,
    bool? isDeleted,
  }) {
    phraseModel = phraseModel.copyWith(
      phrase: phrase,
      font: font,
      description: description,
      observer: observer,
      isArchived: isArchived,
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
