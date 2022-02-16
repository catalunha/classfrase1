import 'package:classfrase/data/model/user_model.dart';
import 'package:classfrase/data/repository/user_repository.dart';
import 'package:classfrase/logic/auth/auth_controller.dart';
import 'package:get/get.dart';

class UserController extends GetxService {
  final UserRepository _userRepository = Get.put(UserRepository());
  final AuthController _splashController = Get.find<AuthController>();

  final String firebaseUserUid;
  UserController({required this.firebaseUserUid});

  late UserModel _userModel;
  get userModel => _userModel;

  Future<bool> getUser() async {
    Map<String, dynamic>? user;
    user = await _userRepository.getByUid(firebaseUserUid);
    if (user == null) {
      await createUser();
    } else {
      _userModel = UserModel.fromMap(user);
    }
    return true;
  }

  Future<bool> createUser() async {
    Map<String, dynamic> data = {};
    data['uid'] = _splashController.firebaseUser!.uid;
    data['email'] = _splashController.firebaseUser!.email;
    data['displayName'] = _splashController.firebaseUser?.displayName;
    data['photoURL'] = _splashController.firebaseUser?.photoURL;
    data['isActive'] = true;
    data['publicPhraseQuota'] = 14;
    Map<String, dynamic> userMap = await _userRepository.create(data);
    _userModel = UserModel.fromMap(userMap);

    return true;
  }
}
