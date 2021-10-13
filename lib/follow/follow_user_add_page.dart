import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/input_checkboxDelete.dart';
import 'package:classfrase/widget/input_description.dart';
import 'package:classfrase/widget/required_inform.dart';
import 'package:flutter/material.dart';

import 'controller/follow_addedit_page_controller.dart';
import 'controller/follow_model.dart';
import 'controller/follow_user_add_page_controller.dart';

class FollowUserAddPage extends StatefulWidget {
  final FormControllerFollowUserAdd formControllerFollowUserAdd;
  final Function(String) onSave;

  const FollowUserAddPage({
    Key? key,
    required this.formControllerFollowUserAdd,
    required this.onSave,
  }) : super(key: key);

  @override
  _FollowUserAddPageState createState() =>
      _FollowUserAddPageState(formControllerFollowUserAdd);
}

class _FollowUserAddPageState extends State<FollowUserAddPage> {
  final FormControllerFollowUserAdd formControllerFollowUserAdd;

  _FollowUserAddPageState(this.formControllerFollowUserAdd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar uma pessoa'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: widget.formControllerFollowUserAdd.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDescription(
                  label: 'Informe o email completo',
                  required: true,
                  initialValue: widget.formControllerFollowUserAdd.email,
                  validator:
                      widget.formControllerFollowUserAdd.validateRequiredText,
                  onChanged: (value) {
                    widget.formControllerFollowUserAdd.onChange(email: value);
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
          widget.formControllerFollowUserAdd.onCheckValidation();
          if (widget.formControllerFollowUserAdd.isFormValid) {
            widget.onSave(widget.formControllerFollowUserAdd.email);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
