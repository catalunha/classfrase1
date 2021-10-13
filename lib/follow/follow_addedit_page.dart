import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/input_checkboxDelete.dart';
import 'package:classfrase/widget/input_description.dart';
import 'package:classfrase/widget/required_inform.dart';
import 'package:flutter/material.dart';

import 'controller/follow_addedit_page_controller.dart';
import 'controller/follow_model.dart';

class FollowAddEditPage extends StatefulWidget {
  final FormControllerFollow formControllerFollow;
  final Function(FollowModel) onSave;

  const FollowAddEditPage({
    Key? key,
    required this.formControllerFollow,
    required this.onSave,
  }) : super(key: key);

  @override
  _FollowAddEditPageState createState() =>
      _FollowAddEditPageState(formControllerFollow);
}

class _FollowAddEditPageState extends State<FollowAddEditPage> {
  final FormControllerFollow formControllerFollow;

  _FollowAddEditPageState(this.formControllerFollow);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formControllerFollow.followModel.id.isEmpty
            ? 'Adicionar um grupo'
            : 'Editar este grupo'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: widget.formControllerFollow.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputDescription(
                  label: 'Informe uma descrição deste grupo',
                  required: true,
                  initialValue:
                      widget.formControllerFollow.followModel.description,
                  validator: widget.formControllerFollow.validateRequiredText,
                  onChanged: (value) {
                    widget.formControllerFollow.onChange(description: value);
                  },
                ),
                formControllerFollow.followModel.id.isEmpty
                    ? Container()
                    : InputCheckBoxDelete(
                        title: 'Apagar este grupo',
                        subtitle: 'Remover permanentemente',
                        value:
                            widget.formControllerFollow.followModel.isDeleted,
                        onChanged: (value) {
                          widget.formControllerFollow
                              .onChange(isDeleted: value);
                          setState(() {});
                        },
                      ),
                RequiredInForm(),
                SizedBox(
                  height: 80,
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Salvar estes campos em núvem',
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          widget.formControllerFollow.onCheckValidation();
          if (widget.formControllerFollow.isFormValid) {
            widget.onSave(widget.formControllerFollow.followModel);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
