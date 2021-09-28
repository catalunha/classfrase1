import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/input_checkbox.dart';
import 'package:classfrase/widget/input_checkboxDelete.dart';
import 'package:classfrase/widget/input_description.dart';
import 'package:classfrase/widget/input_title.dart';
import 'package:flutter/material.dart';

import 'controller/phrase_addedit_connector.dart';
import 'controller/phrase_model.dart';

class PhraseAddEditPage extends StatefulWidget {
  final FormController formController;
  final Function(PhraseModel) onSave;

  const PhraseAddEditPage({
    Key? key,
    required this.formController,
    required this.onSave,
  }) : super(key: key);

  @override
  _PhraseAddEditPageState createState() =>
      _PhraseAddEditPageState(formController);
}

class _PhraseAddEditPageState extends State<PhraseAddEditPage> {
  final FormController formController;

  _PhraseAddEditPageState(this.formController);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formController.phraseModel.id.isEmpty
            ? 'Adicionar uma frase'
            : 'Editar esta frase'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: widget.formController.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDescription(
                  label: 'Informe a frase',
                  initialValue: widget.formController.phraseModel.phrase,
                  validator: widget.formController.validateRequiredText,
                  onChanged: (value) {
                    widget.formController.onChange(phrase: value);
                  },
                ),
                InputTitle(
                  label: 'Fonte desta frase',
                  initialValue: widget.formController.phraseModel.font,
                  // validator: widget.formController.validateRequiredText,
                  onChanged: (value) {
                    widget.formController.onChange(font: value);
                  },
                ),
                InputTitle(
                  label: 'Descrição desta frase',
                  initialValue: widget.formController.phraseModel.description,
                  // validator: widget.formController.validateRequiredText,
                  onChanged: (value) {
                    widget.formController.onChange(description: value);
                  },
                ),
                formController.phraseModel.id.isEmpty
                    ? Container()
                    : InputCheckBox(
                        title: 'Arquivar esta frase',
                        subtitle: 'Arquivar esta frase',
                        value: formController.phraseModel.isArchived,
                        onChanged: (value) {
                          formController.onChange(isArchived: value);
                          setState(() {});
                        },
                      ),
                formController.phraseModel.id.isEmpty
                    ? Container()
                    : InputCheckBoxDelete(
                        title: 'Apagar esta frase',
                        subtitle: 'Remover permanentemente',
                        value: widget.formController.phraseModel.isDeleted,
                        onChanged: (value) {
                          widget.formController.onChange(isDeleted: value);
                          setState(() {});
                        },
                      ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          widget.formController.onCheckValidation();
          if (widget.formController.isFormValid) {
            widget.onSave(widget.formController.phraseModel);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
