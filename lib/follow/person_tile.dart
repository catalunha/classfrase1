import 'package:classfrase/theme/app_icon.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/material.dart';

class PersonTile extends StatelessWidget {
  final UserRef userRef;

  const PersonTile({Key? key, required this.userRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: userRef.photoURL == null
          ? Icon(AppIconData.undefined)
          : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                userRef.photoURL!,
                height: 58,
                width: 58,
              ),
            ),
      // tileColor: Colors.black12,
      title: Text(
        userRef.displayName ?? 'Pessoa sem nome.',
        // style: AppTextStyles.buttonBoldHeading,
      ),
      // subtitle: Text(
      //   userRef.userRef,
      // ),
    );
  }
}
