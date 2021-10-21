import 'package:classfrase/widget/input_title.dart';
import 'package:flutter/material.dart';
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
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: widget.formControllerLearnUserAdd.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Adicionar pessoa neste grupo'),
                InputTitle(
                  label: 'Informe o email completo',
                  required: true,
                  initialValue: widget.formControllerLearnUserAdd.email,
                  validator:
                      widget.formControllerLearnUserAdd.validateRequiredText,
                  onChanged: (value) {
                    widget.formControllerLearnUserAdd.onChange(email: value);
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
                          widget.formControllerLearnUserAdd.onCheckValidation();
                          if (widget.formControllerLearnUserAdd.isFormValid) {
                            widget.onSave(
                                widget.formControllerLearnUserAdd.email);
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Buscar')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
