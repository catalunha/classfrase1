import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/input_checkbox.dart';
import 'package:classfrase/widget/input_checkboxDelete.dart';
import 'package:classfrase/widget/input_description.dart';
import 'package:flutter/material.dart';

import 'controller/observer_addedit_page_controller.dart';
import 'controller/observer_model.dart';

class ObserverAddEditPage extends StatefulWidget {
  final FormControllerObserver formControllerObserver;
  final Function(ObserverModel) onSave;

  const ObserverAddEditPage({
    Key? key,
    required this.formControllerObserver,
    required this.onSave,
  }) : super(key: key);

  @override
  _ObserverAddEditPageState createState() =>
      _ObserverAddEditPageState(formControllerObserver);
}

class _ObserverAddEditPageState extends State<ObserverAddEditPage> {
  final FormControllerObserver formControllerObserver;

  _ObserverAddEditPageState(this.formControllerObserver);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formControllerObserver.observerModel.id.isEmpty
            ? 'Adicionar uma observação'
            : 'Editar esta observação'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: widget.formControllerObserver.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDescription(
                  label: 'Informe uma descrição da observação',
                  initialValue:
                      widget.formControllerObserver.observerModel.description,
                  validator: widget.formControllerObserver.validateRequiredText,
                  onChanged: (value) {
                    widget.formControllerObserver.onChange(description: value);
                  },
                ),
                formControllerObserver.observerModel.id.isEmpty
                    ? Container()
                    : InputCheckBoxDelete(
                        title: 'Apagar esta frase',
                        subtitle: 'Remover permanentemente',
                        value: widget
                            .formControllerObserver.observerModel.isDeleted,
                        onChanged: (value) {
                          widget.formControllerObserver
                              .onChange(isDeleted: value);
                          setState(() {});
                        },
                      ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          widget.formControllerObserver.onCheckValidation();
          if (widget.formControllerObserver.isFormValid) {
            widget.onSave(widget.formControllerObserver.observerModel);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
