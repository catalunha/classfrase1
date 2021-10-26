import 'package:classfrase/widget/input_checkboxDelete.dart';
import 'package:classfrase/widget/input_title.dart';
import 'package:flutter/material.dart';

import 'controller/learn_addedit_page_connector.dart';
import 'controller/learn_model.dart';

class LearnAddEditPage extends StatefulWidget {
  final FormControllerLearn formControllerLearn;
  final Function(LearnModel) onSave;

  const LearnAddEditPage({
    Key? key,
    required this.formControllerLearn,
    required this.onSave,
  }) : super(key: key);

  @override
  _LearnAddEditPageState createState() =>
      _LearnAddEditPageState(formControllerLearn);
}

class _LearnAddEditPageState extends State<LearnAddEditPage> {
  final FormControllerLearn formControllerLearn;

  _LearnAddEditPageState(this.formControllerLearn);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
              key: widget.formControllerLearn.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.formControllerLearn.learnModel.id.isEmpty
                      ? 'Adicionar um grupo.'
                      : 'Editar este grupo.'),
                  InputTitle(
                    label: 'Título do grupo',
                    required: true,
                    initialValue:
                        widget.formControllerLearn.learnModel.description,
                    validator: widget.formControllerLearn.validateRequiredText,
                    onChanged: (value) {
                      widget.formControllerLearn.onChange(description: value);
                    },
                  ),
                  formControllerLearn.learnModel.id.isEmpty
                      ? Container()
                      : InputCheckBoxDelete(
                          title: 'Apagar este grupo',
                          subtitle: 'Remover permanentemente',
                          value:
                              widget.formControllerLearn.learnModel.isDeleted,
                          onChanged: (value) {
                            widget.formControllerLearn
                                .onChange(isDeleted: value);
                            setState(() {});
                          },
                        ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancelar')),
                      SizedBox(
                        width: 50,
                      ),
                      TextButton(
                          onPressed: () {
                            widget.formControllerLearn.onCheckValidation();
                            if (widget.formControllerLearn.isFormValid) {
                              widget.onSave(
                                  widget.formControllerLearn.learnModel);
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                              widget.formControllerLearn.learnModel.id.isEmpty
                                  ? 'Adicionar'
                                  : 'Editar')),
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
