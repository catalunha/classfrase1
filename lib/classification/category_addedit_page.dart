import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/input_checkboxDelete.dart';
import 'package:classfrase/widget/input_title.dart';
import 'package:flutter/material.dart';

import 'controller/category_addedit_page_controller.dart';
import 'controller/classification_model.dart';

class CategoryAddEditPage extends StatefulWidget {
  final FormControllerCategory formControllerCategory;
  final Function(ClassCategory, bool) onSave;

  const CategoryAddEditPage({
    Key? key,
    required this.formControllerCategory,
    required this.onSave,
  }) : super(key: key);

  @override
  _CategoryAddEditPageState createState() =>
      _CategoryAddEditPageState(formControllerCategory);
}

class _CategoryAddEditPageState extends State<CategoryAddEditPage> {
  final FormControllerCategory formControllerCategory;

  _CategoryAddEditPageState(this.formControllerCategory);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.formControllerCategory.category.id!.isEmpty
            ? 'Adicionar uma categoria'
            : 'Editar esta categoria'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: widget.formControllerCategory.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTitle(
                  label: 'Informe o nome do grupo de classificação',
                  initialValue: widget.formControllerCategory.category.title,
                  required: true,
                  validator: widget.formControllerCategory.validateRequiredText,
                  onChanged: (value) {
                    widget.formControllerCategory.onChange(title: value);
                  },
                ),
                InputTitle(
                  label: 'ID deste grupo',
                  initialValue: widget.formControllerCategory.category.group,
                  required: true,
                  validator: widget.formControllerCategory.validateRequiredText,
                  onChanged: (value) {
                    widget.formControllerCategory.onChange(group: value);
                  },
                ),
                InputTitle(
                  label: 'Informe o link do tutorial deste grupo',
                  icon: AppIconData.linkOn,
                  initialValue: widget.formControllerCategory.category.url,
                  onChanged: (value) {
                    widget.formControllerCategory.onChange(url: value);
                  },
                ),
                InputCheckBoxDelete(
                  title: 'Apagar este grupo',
                  subtitle: 'Remover permanentemente',
                  value: widget.formControllerCategory.delete,
                  onChanged: (value) {
                    widget.formControllerCategory.onChange(delete: value);
                    setState(() {});
                  },
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          widget.formControllerCategory.onCheckValidation();
          if (widget.formControllerCategory.isFormValid) {
            widget.onSave(widget.formControllerCategory.category,
                widget.formControllerCategory.delete);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
