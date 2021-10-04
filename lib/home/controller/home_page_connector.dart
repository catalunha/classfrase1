import 'package:async_redux/async_redux.dart';
import 'package:classfrase/classification/controller/classification_action.dart';
import 'package:classfrase/login/controller/login_action.dart';
import 'package:classfrase/phrase/controller/phrase_action.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';

import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../home_page.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      vm: () => HomeViewModelFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsPhraseAction());
        store.dispatch(ReadDocClassificationAction());
        print('home onInit');
      },
      builder: (context, vm) => HomePage(
        signOut: vm.signOut,
        photoUrl: vm.photoUrl,
        displayName: vm.displayName,
        uid: vm.uid,
        id: vm.id,
        email: vm.email,
        phraseList: vm.phraseList,
      ),
    );
  }
}

class HomeViewModelFactory extends VmFactory<AppState, HomePageConnector> {
  HomeViewModelFactory(widget) : super(widget);
  @override
  HomeViewModel fromStore() => HomeViewModel(
        signOut: () => dispatch(SignOutLoginAction()),
        photoUrl: state.userState.userCurrent!.photoURL ?? '',
        displayName: state.userState.userCurrent!.displayName ?? '',
        email: state.userState.userCurrent!.email,
        uid: state.userState.userFirebaseAuth?.uid ?? '',
        id: state.userState.userCurrent!.id,
        phraseList: state.phraseState.phraseList!,
      );
}

class HomeViewModel extends Vm {
  final VoidCallback signOut;

  final String displayName;
  final String photoUrl;
  final String email;
  final String uid;
  final String id;
  final List<PhraseModel> phraseList;
  HomeViewModel({
    required this.signOut,
    required this.photoUrl,
    required this.displayName,
    required this.email,
    required this.uid,
    required this.id,
    required this.phraseList,
  }) : super(equals: [
          photoUrl,
          displayName,
          email,
          uid,
          id,
          phraseList,
        ]);
}
