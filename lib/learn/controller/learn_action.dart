import 'package:async_redux/async_redux.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_state.dart';
import 'learn_model.dart';

class StreamDocsLearnAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    //print('--> StreamDocsObserverAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(LearnModel.collection)
        .where('userRef.id', isEqualTo: state.userState.userCurrent!.id)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<LearnModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                LearnModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<LearnModel> learnModelList) {
      dispatch(SetLearnListLearnAction(learnList: learnModelList));
    });

    return null;
  }
}

class SetLearnListLearnAction extends ReduxAction<AppState> {
  final List<LearnModel> learnList;

  SetLearnListLearnAction({required this.learnList});
  @override
  AppState reduce() {
    return state.copyWith(
      learnState: state.learnState.copyWith(
        learnList: learnList,
      ),
    );
  }

  void after() {
    if (state.learnState.learnCurrent != null) {
      dispatch(
          SetLearnCurrentLearnAction(id: state.learnState.learnCurrent!.id));
    }
  }
}

class SetLearnCurrentLearnAction extends ReduxAction<AppState> {
  final String id;
  SetLearnCurrentLearnAction({
    required this.id,
  });
  @override
  AppState reduce() {
    //print('--> SetObserverCurrentObserverAction $id');
    LearnModel learnModel = LearnModel(
      '',
      userRef: UserRef.fromMap({
        'id': state.userState.userCurrent!.id,
        'photoURL': state.userState.userCurrent!.photoURL,
        'displayName': state.userState.userCurrent!.displayName
      }),
      description: '',
      learning: {},
      isDeleted: false,
    );
    if (id.isNotEmpty) {
      learnModel =
          state.learnState.learnList!.firstWhere((element) => element.id == id);
    }
    return state.copyWith(
      learnState: state.learnState.copyWith(
        learnCurrent: learnModel,
      ),
    );
  }

  void after() {
    dispatch(SetNullUserAndPhraseLearnAction());
  }
}

class SetNullUserAndPhraseLearnAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      learnState: state.learnState.copyWith(
        userRefCurrentSetNull: true,
        phraseListSetNull: true,
        phraseCurrentSetNull: true,
      ),
    );
  }
}

class CreateDocLearnAction extends ReduxAction<AppState> {
  final LearnModel learnModel;

  CreateDocLearnAction({required this.learnModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(LearnModel.collection);
    await docRef.add(learnModel.toMap());
    return null;
  }
}

class UpdateDocLearnAction extends ReduxAction<AppState> {
  final LearnModel learnModel;

  UpdateDocLearnAction({required this.learnModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(LearnModel.collection).doc(learnModel.id);
    await docRef.update(learnModel.toMap());

    return null;
  }
}

class SearchingEmailLearnAction extends ReduxAction<AppState> {
  final String email;
  SearchingEmailLearnAction({required this.email});

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

      dispatch(AddLearningUserLearnAction(userModel: userModelList[0]));
    } else {
      print('Email não encontrado.');
    }
    return null;
  }
}

class AddLearningUserLearnAction extends ReduxAction<AppState> {
  final UserModel userModel;

  AddLearningUserLearnAction({required this.userModel});

  @override
  Future<AppState?> reduce() async {
    LearnModel learnModel = state.learnState.learnCurrent!;
    bool userCadastrado = learnModel.learning.containsKey(userModel.id);
    if (userCadastrado) {
      print('Email já tem na lista');
    } else {
      print('Cadastrar pois email não esta em learns');
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      DocumentReference docRef = firebaseFirestore
          .collection(LearnModel.collection)
          .doc(learnModel.id);
      UserRef userRef = UserRef(
          id: userModel.id,
          photoURL: userModel.photoURL,
          displayName: userModel.displayName);
      // learnModel.learning.addAll({userModel.id: userRef});
      // await docRef.update(learnModel.toMap());
      await docRef.update({'learning.${userModel.id}': userRef.toMap()});
    }

    return null;
  }
}

class DeleteLearningUserLearnAction extends ReduxAction<AppState> {
  final String userId;

  DeleteLearningUserLearnAction({required this.userId});

  @override
  Future<AppState?> reduce() async {
    LearnModel learnModel = state.learnState.learnCurrent!;

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(LearnModel.collection).doc(learnModel.id);
    await docRef.update({'learning.$userId': FieldValue.delete()});

    return null;
  }
}

class SetUserCurrentLearnAction extends ReduxAction<AppState> {
  final String id;
  SetUserCurrentLearnAction({
    required this.id,
  });
  @override
  AppState? reduce() {
    UserRef userRef;
    if (state.learnState.learnCurrent!.learning.containsKey(id)) {
      userRef = state.learnState.learnCurrent!.learning[id]!;

      return state.copyWith(
        learnState: state.learnState.copyWith(
          userRefCurrent: userRef,
        ),
      );
    }
    return null;
  }

  void after() {
    dispatch(SetNullPhraseLearnAction());
  }
}

class SetNullPhraseLearnAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      learnState: state.learnState.copyWith(
        phraseListSetNull: true,
        phraseCurrentSetNull: true,
      ),
    );
  }
}

class GetDocsPhraseLearnAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    //print('--> StreamDocsObserverAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(PhraseModel.collection)
        .where('userRef.id', isEqualTo: state.learnState.userRefCurrent!.id)
        .where('isDeleted', isEqualTo: false)
        .where('isArchived', isEqualTo: false)
        .where('isPublic', isEqualTo: true);

    var futureQuerySnapshot = await collRef.get();
    var phraseList = futureQuerySnapshot.docs
        .map((docSnapshot) =>
            PhraseModel.fromMap(docSnapshot.id, docSnapshot.data()))
        .toList();
    dispatch(SetPhraseListLearnAction(phraseList: phraseList));

    return null;
  }
}

class SetPhraseListLearnAction extends ReduxAction<AppState> {
  final List<PhraseModel> phraseList;

  SetPhraseListLearnAction({required this.phraseList});
  @override
  AppState reduce() {
    return state.copyWith(
      learnState: state.learnState.copyWith(
        phraseList: phraseList,
      ),
    );
  }

  // void after() {
  //   if (state.phraseState.phraseCurrent != null) {
  //     dispatch(SetPhraseCurrentPhraseAction(
  //         id: state.phraseState.phraseCurrent!.id));
  //   }
  // }
}

class SetPhraseCurrentLearnAction extends ReduxAction<AppState> {
  final String id;
  SetPhraseCurrentLearnAction({
    required this.id,
  });
  @override
  AppState reduce() {
    PhraseModel phraseModel;
    phraseModel =
        state.learnState.phraseList!.firstWhere((element) => element.id == id);
    return state.copyWith(
      learnState: state.learnState.copyWith(
        phraseCurrent: phraseModel,
      ),
    );
  }
}
