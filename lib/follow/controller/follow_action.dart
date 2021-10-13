import 'package:async_redux/async_redux.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_state.dart';
import 'follow_model.dart';

class StreamDocsFollowAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    //print('--> StreamDocsObserverAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(FollowModel.collection)
        .where('userRef.id', isEqualTo: state.userState.userCurrent!.id)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<FollowModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                FollowModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<FollowModel> followModelList) {
      dispatch(SetFollowListFollowAction(followList: followModelList));
    });

    return null;
  }
}

class SetFollowListFollowAction extends ReduxAction<AppState> {
  final List<FollowModel> followList;

  SetFollowListFollowAction({required this.followList});
  @override
  AppState reduce() {
    return state.copyWith(
      followState: state.followState.copyWith(
        followList: followList,
      ),
    );
  }

  void after() {
    if (state.followState.followCurrent != null) {
      dispatch(SetFollowCurrentFollowAction(
          id: state.followState.followCurrent!.id));
    }
  }
}

class SetFollowCurrentFollowAction extends ReduxAction<AppState> {
  final String id;
  SetFollowCurrentFollowAction({
    required this.id,
  });
  @override
  AppState reduce() {
    //print('--> SetObserverCurrentObserverAction $id');
    FollowModel followModel = FollowModel(
      '',
      userRef: UserRef.fromMap({
        'id': state.userState.userCurrent!.id,
        'photoURL': state.userState.userCurrent!.photoURL,
        'displayName': state.userState.userCurrent!.displayName
      }),
      description: '',
      following: {},
      isDeleted: false,
    );
    if (id.isNotEmpty) {
      followModel = state.followState.followList!
          .firstWhere((element) => element.id == id);
    }
    return state.copyWith(
      followState: state.followState.copyWith(
        followCurrent: followModel,
      ),
    );
  }

  void after() {
    dispatch(SetNulUserAndPhraseFollowAction());
  }
}

class SetNulUserAndPhraseFollowAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      followState: state.followState.copyWith(
        // userRefListSetNull: true,
        userRefCurrentSetNull: true,
        phraseListSetNull: true,
        phraseCurrentSetNull: true,
      ),
    );
  }
}

class CreateDocFollowAction extends ReduxAction<AppState> {
  final FollowModel followModel;

  CreateDocFollowAction({required this.followModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(FollowModel.collection);
    await docRef.add(followModel.toMap());
    return null;
  }
}

class UpdateDocFollowAction extends ReduxAction<AppState> {
  final FollowModel followModel;

  UpdateDocFollowAction({required this.followModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(FollowModel.collection)
        .doc(followModel.id);
    await docRef.update(followModel.toMap());

    return null;
  }
}

class SearchingEmailFollowAction extends ReduxAction<AppState> {
  final String email;
  SearchingEmailFollowAction({required this.email});

  @override
  Future<AppState?> reduce() async {
    //print('--> ReadDocsPhraseAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var documentReference = await firebaseFirestore
        .collection(UserModel.collection)
        .where('email', isEqualTo: email)
        .get();
    if (documentReference.size == 1) {
      var userModelList = documentReference.docs
          .map((e) => UserModel.fromMap(
                e.id,
                e.data(),
              ))
          .toList();

      dispatch(UpdateFollowingUserFollowAction(userModel: userModelList[0]));
    } else {
      print('Email não encontrado.');
    }
    return null;
  }
}

class UpdateFollowingUserFollowAction extends ReduxAction<AppState> {
  final UserModel userModel;

  UpdateFollowingUserFollowAction({required this.userModel});

  @override
  Future<AppState?> reduce() async {
    FollowModel followModel = state.followState.followCurrent!;
    bool userCadastrado = followModel.following.containsKey(userModel.id);
    if (userCadastrado) {
      print('Email já tem na lista');
    } else {
      print('Cadastrar pois email não esta em follows');
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      DocumentReference docRef = firebaseFirestore
          .collection(FollowModel.collection)
          .doc(followModel.id);
      UserRef userRef = UserRef(
          id: userModel.id,
          photoURL: userModel.photoURL,
          displayName: userModel.displayName);
      // followModel.following.addAll({userModel.id: userRef});
      // await docRef.update(followModel.toMap());
      await docRef.update({'following.${userModel.id}': userRef.toMap()});
    }

    return null;
  }
}
