import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../category_addedit_page.dart';
import 'classification_action.dart';
import 'classification_model.dart';

class CategoryAddEditPageConnector extends StatelessWidget {
  final String addOrEditId;
  const CategoryAddEditPageConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, CategoryAddEditPageVm>(
      onInit: (store) {
        store.dispatch(SetCategoryCurrentClassificationAction(id: addOrEditId));
      },
      vm: () => CategoryAddEditPageFactory(this),
      builder: (context, vm) => CategoryAddEditPage(
        formControllerCategory: vm.formControllerCategory,
        onSave: vm.onSave,
      ),
    );
  }
}

class CategoryAddEditPageFactory
    extends VmFactory<AppState, CategoryAddEditPageConnector> {
  CategoryAddEditPageFactory(widget) : super(widget);
  @override
  CategoryAddEditPageVm fromStore() => CategoryAddEditPageVm(
        formControllerCategory: FormControllerCategory(
            category: state.classificationState.categoryCurrent!),
        onSave: (ClassCategory category) {
          dispatch(
              UpdateDocCategoryClassificationAction(classCategory: category));
        },
      );
}

class CategoryAddEditPageVm extends Vm {
  final FormControllerCategory formControllerCategory;
  final Function(ClassCategory) onSave;

  CategoryAddEditPageVm({
    required this.formControllerCategory,
    required this.onSave,
  }) : super(equals: [
          formControllerCategory,
        ]);
}

class FormControllerCategory {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  ClassCategory category;
  FormControllerCategory({
    required this.category,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
  void onChange({
    String? title,
    String? url,
  }) {
    category = category.copyWith(
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
