import 'package:classfrase/data/service/auth_service.dart';
import 'package:classfrase/logic/service/user_controller.dart';
import 'package:classfrase/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final AuthService _authService;

  User? _firebaseUser;
  get firebaseUser => _firebaseUser;

  AuthController({required AuthService authService})
      : _authService = authService;

  @override
  void onInit() {
    _firebaseUser = null;
    super.onInit();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    // firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    // googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    // firebaseUser.bindStream(firebaseAuth.userChanges());
    // ever(firebaseUser, _setInitialScreen);

    // googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    // ever(googleSignInAccount, _setInitialScreenGoogle);
    // authService.setInitialScreenFirebaseUser = _setInitialScreen;
    // authService.setInitialScreenGoogle = _setInitialScreenGoogle;
    _authService.startService(
      setInitialScreenFirebaseUser: _setInitialScreenFirebaseUser,
      setInitialScreenGoogle: _setInitialScreenGoogle,
    );
    // authService.onReady();
  }

  _setInitialScreenFirebaseUser(User? user) async {
    // print('_setInitialScreenFirebaseUser');
    // print('routes: ${Get.routing.current}');

    if (user == null) {
      // if (user == null && Get.routing.current != RoutesPaths.login) {
      // print('_setInitialScreenFirebaseUser: user==null');
      // print('Indo para a route: login');

      // if the user is not found then the user is navigated to the LoginPage
      // Get.offAll(() => const LoginPage());
      Get.offAllNamed(Routes.login);
    } else if (firebaseUser == null) {
      // if (user != null && Get.routing.current != RoutesPaths.home) {
      _firebaseUser = user;
      // print('_setInitialScreenFirebaseUser: user!=null');
      // print('Indo para a route: home');
      // print('user.uid:${user.uid}');
      // print('user.displayName:${user.displayName ?? "null"}');
      // print('user.email:${user.email ?? "null"}');
      // print('user.phoneNumber:${user.phoneNumber ?? "null"}');
      // print('user.photoURL:${user.photoURL ?? "null"}');
      final userController = Get.put(
        UserController(firebaseUserUid: user.uid),
        permanent: true,
      );
      bool temp = await userController.getUser();

      // if the user exists and logged in the the user is navigated to the HomePage
      // Get.offAll(() => HomePage());
      if (temp) {
        Get.offAllNamed(
          Routes.home,
        );
      } else {
        signOut();
      }
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    // print('_setInitialScreenGoogle');
    // print('routes: ${Get.routing.current}');

    if (googleSignInAccount == null && Get.routing.current != Routes.login) {
      // print('_setInitialScreenGoogle: googleSignInAccount==null');
      // print('Indo para a route: login');

      // if the user is not found then the user is navigated to the LoginPage
      // Get.offAll(() => LoginPage());
      Get.offAllNamed(Routes.login);
    } else if (googleSignInAccount != null &&
        Get.routing.current != Routes.home) {
      // print('_setInitialScreenGoogle: googleSignInAccount!=null');
      // // print('Indo para a route: home');
      // print('user.id:${googleSignInAccount.id}');
      // print(
      //     'user.serverAuthCode:${googleSignInAccount.serverAuthCode ?? "null"}');
      // print('user.displayName:${googleSignInAccount.displayName ?? "null"}');
      // print('user.email:${googleSignInAccount.email}');
      // print('user.photoUrl:${googleSignInAccount.photoUrl ?? "null"}');
      // print(googleSignInAccount.displayName);
      // if the user exists and logged in the the user is navigated to the HomePage
      // Get.offAll(() => HomePage());
      // Get.offAllNamed(
      //   RoutesPaths.home,
      // );
    }
  }

  void signInWithGoogle() async {
    try {
      _authService.signInWithGoogle();
      // GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      // if (googleSignInAccount != null) {
      //   GoogleSignInAuthentication googleSignInAuthentication =
      //       await googleSignInAccount.authentication;

      //   AuthCredential credential = GoogleAuthProvider.credential(
      //     accessToken: googleSignInAuthentication.accessToken,
      //     idToken: googleSignInAuthentication.idToken,
      //   );

      //   await firebaseAuth
      //       .signInWithCredential(credential)
      //       .catchError((onErr) => print(onErr));
      // }
    } catch (e) {
      Get.snackbar(
        "Error in signInWithGoogle",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // void createUserWithEmailAndPassword(String email, password) async {
  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } catch (firebaseAuthException) {}
  // }

  // void signInWithEmailAndPassword(String email, password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(email: email, password: password);
  //   } catch (firebaseAuthException) {}
  // }

  void signOut() async {
    _firebaseUser = null;
    _authService.signOut();
    // await googleSign.disconnect();
    // await firebaseAuth.signOut();
  }
}
