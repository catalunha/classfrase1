import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/widget/input_checkboxDelete.dart';
import 'package:classfrase/widget/input_title.dart';
import 'package:classfrase/widget/required_inform.dart';
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
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: widget.formControllerObserver.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.formControllerObserver.observerModel.id.isEmpty
                    ? 'Cadastrar um ID de observador'
                    : 'Editar este ID de observador'),
                InputTitle(
                  label: 'Informe um título para o ID (Identificador)',
                  required: true,
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
                          widget.formControllerObserver.onCheckValidation();
                          if (widget.formControllerObserver.isFormValid) {
                            widget.onSave(
                                widget.formControllerObserver.observerModel);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(widget
                                .formControllerObserver.observerModel.id.isEmpty
                            ? 'Adicionar'
                            : 'Editar')),
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



// class ObserverAddEditPage extends StatefulWidget {
//   final FormControllerObserver formControllerObserver;
//   final Function(ObserverModel) onSave;

//   const ObserverAddEditPage({
//     Key? key,
//     required this.formControllerObserver,
//     required this.onSave,
//   }) : super(key: key);

//   @override
//   _ObserverAddEditPageState createState() =>
//       _ObserverAddEditPageState(formControllerObserver);
// }

// class _ObserverAddEditPageState extends State<ObserverAddEditPage> {
//   final FormControllerObserver formControllerObserver;

//   _ObserverAddEditPageState(this.formControllerObserver);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.formControllerObserver.observerModel.id.isEmpty
//             ? 'Adicionar um ID de observador'
//             : 'Editar este ID de observador'),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//             key: widget.formControllerObserver.formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 InputTitle(
//                   label: 'Informe um título para o ID (Identificador)',
//                   required: true,
//                   initialValue:
//                       widget.formControllerObserver.observerModel.description,
//                   validator: widget.formControllerObserver.validateRequiredText,
//                   onChanged: (value) {
//                     widget.formControllerObserver.onChange(description: value);
//                   },
//                 ),
//                 formControllerObserver.observerModel.id.isEmpty
//                     ? Container()
//                     : InputCheckBoxDelete(
//                         title: 'Apagar esta frase',
//                         subtitle: 'Remover permanentemente',
//                         value: widget
//                             .formControllerObserver.observerModel.isDeleted,
//                         onChanged: (value) {
//                           widget.formControllerObserver
//                               .onChange(isDeleted: value);
//                           setState(() {});
//                         },
//                       ),
//                 RequiredInForm(),
//                 SizedBox(
//                   height: 80,
//                 ),
//               ],
//             )),
//       ),
//       floatingActionButton: FloatingActionButton(
//         tooltip: 'Salvar estes campos em núvem',
//         child: Icon(AppIconData.saveInCloud),
//         onPressed: () {
//           widget.formControllerObserver.onCheckValidation();
//           if (widget.formControllerObserver.isFormValid) {
//             widget.onSave(widget.formControllerObserver.observerModel);
//             Navigator.pop(context);
//           }
//         },
//       ),
//     );
//   }
// }
