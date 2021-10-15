import 'package:classfrase/theme/app_icon.dart';
import 'package:flutter/material.dart';

class PersonTile extends StatelessWidget {
  final String? displayName;
  final String? photoURL;
  final String? email;
  final String? id;
  final String? uid;
  final Widget? trailingIconButton;

  const PersonTile({
    Key? key,
    required this.displayName,
    required this.photoURL,
    this.email,
    this.id,
    this.uid,
    this.trailingIconButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: photoURL == null
          ? Icon(AppIconData.undefined)
          : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                photoURL!,
                height: 58,
                width: 58,
              ),
            ),
      // tileColor: Colors.black12,
      title: Text(
        displayName ?? 'Pessoa sem nome.',
        // style: AppTextStyles.buttonBoldHeading,
      ),
      // subtitle: Text(
      //   'Classificador(a).',
      // ),
      trailing: trailingIconButton,
    );
  }
}


// class PersonTile extends StatelessWidget {
//   final String displayName;
//   final String photoURL;
//   final String? email;
//   final String? id;
//   final String? uid;
//   final UserRef userRef;
//   final Function(String)? trailingIconButton;

//   const PersonTile({
//     Key? key,
//     required this.userRef,
//     this.trailingIconButton,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: userRef.photoURL == null
//           ? Icon(AppIconData.undefined)
//           : ClipRRect(
//               borderRadius: BorderRadius.circular(8.0),
//               child: Image.network(
//                 userRef.photoURL!,
//                 height: 58,
//                 width: 58,
//               ),
//             ),
//       // tileColor: Colors.black12,
//       title: Text(
//         userRef.displayName ?? 'Pessoa sem nome.',
//         // style: AppTextStyles.buttonBoldHeading,
//       ),
//       // subtitle: Text(
//       //   userRef.userRef,
//       // ),
//       trailing: trailingIconButton != null
//           ? IconButton(
//               tooltip: 'Remover este contato deste grupo',
//               icon: Icon(AppIconData.delete),
//               onPressed: () {
//                 trailingIconButton!(userRef.id);
//               },
//             )
//           : null,
//     );
//   }
// }
