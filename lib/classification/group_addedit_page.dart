import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/input_title.dart';
import 'package:flutter/material.dart';

import 'controller/classification_model.dart';
import 'controller/group_addedit_page_controller.dart';

class GroupAddEditPage extends StatefulWidget {
  final FormControllerGroup formControllerGroup;
  final Function(ClassGroup) onSave;

  const GroupAddEditPage({
    Key? key,
    required this.formControllerGroup,
    required this.onSave,
  }) : super(key: key);

  @override
  _GroupAddEditPageState createState() =>
      _GroupAddEditPageState(formControllerGroup);
}

class _GroupAddEditPageState extends State<GroupAddEditPage> {
  final FormControllerGroup formControllerGroup;

  _GroupAddEditPageState(this.formControllerGroup);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formControllerGroup.group.id!.isEmpty
            ? 'Adicionar um grupo'
            : 'Editar este grupo'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: widget.formControllerGroup.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTitle(
                  label: 'Informe o nome do grupo de classificação',
                  initialValue: widget.formControllerGroup.group.title,
                  required: true,
                  validator: widget.formControllerGroup.validateRequiredText,
                  onChanged: (value) {
                    widget.formControllerGroup.onChange(title: value);
                  },
                ),
                InputTitle(
                  label: 'Informe o link do tutorial deste grupo',
                  icon: AppIconData.linkOn,
                  initialValue: widget.formControllerGroup.group.url,
                  onChanged: (value) {
                    widget.formControllerGroup.onChange(url: value);
                  },
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          widget.formControllerGroup.onCheckValidation();
          if (widget.formControllerGroup.isFormValid) {
            widget.onSave(widget.formControllerGroup.group);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
