import 'package:classfrase/app/data/exceptions/user_exceptions.dart';
import 'package:classfrase/app/data/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;

  Future<UserModel> getByUid(String uid) async {
    var querySnapshot = await _firebaseFirestoreInstance
        .collection(UserModel.collection)
        .where('uid', isEqualTo: uid)
        .get();
    if (querySnapshot.docChanges.isEmpty || querySnapshot.size == 0) {
      throw UserNotFoundException();
    }
    if (querySnapshot.size > 1) {
      throw UserMoreThanOneException();
    }
    UserModel userModel =
        UserModel.fromMap(querySnapshot.docChanges.first.doc.data()!);

    return userModel;
  }

  Future<void> create(Map<String, dynamic> data) async {
    CollectionReference docRef =
        _firebaseFirestoreInstance.collection(UserModel.collection);
    String idNew = docRef.doc().id;
    data['id'] = idNew;
    await docRef.doc(idNew).set(data);
  }
}
