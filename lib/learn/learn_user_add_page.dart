import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/input_checkboxDelete.dart';
import 'package:classfrase/widget/input_description.dart';
import 'package:classfrase/widget/required_inform.dart';
import 'package:flutter/material.dart';

import 'controller/learn_addedit_page_controller.dart';
import 'controller/learn_model.dart';
import 'controller/learn_user_add_page_controller.dart';

class LearnUserAddPage extends StatefulWidget {
  final FormControllerLearnUserAdd formControllerLearnUserAdd;
  final Function(String) onSave;

  const LearnUserAddPage({
    Key? key,
    required this.formControllerLearnUserAdd,
    required this.onSave,
  }) : super(key: key);

  @override
  _LearnUserAddPageState createState() =>
      _LearnUserAddPageState(formControllerLearnUserAdd);
}

class _LearnUserAddPageState extends State<LearnUserAddPage> {
  final FormControllerLearnUserAdd formControllerLearnUserAdd;

  _LearnUserAddPageState(this.formControllerLearnUserAdd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar uma pessoa'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: widget.formControllerLearnUserAdd.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDescription(
                  label: 'Informe o email completo',
                  required: true,
                  initialValue: widget.formControllerLearnUserAdd.email,
                  validator:
                      widget.formControllerLearnUserAdd.validateRequiredText,
                  onChanged: (value) {
                    widget.formControllerLearnUserAdd.onChange(email: value);
                  },
                ),
                RequiredInForm(),
                // SizedBox(
                //   height: 80,
                // ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Salvar este campo em núvem',
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          widget.formControllerLearnUserAdd.onCheckValidation();
          if (widget.formControllerLearnUserAdd.isFormValid) {
            widget.onSave(widget.formControllerLearnUserAdd.email);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
