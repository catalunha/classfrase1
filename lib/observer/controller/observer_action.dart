import 'package:async_redux/async_redux.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/user/controller/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_state.dart';
import 'observer_model.dart';

class StreamDocsObserverAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(ObserverModel.collection)
        .where('userRef.id', isEqualTo: state.userState.userCurrent!.id)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<ObserverModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                ObserverModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<ObserverModel> observerModelList) {
      dispatch(SetObserverListObserverAction(observerList: observerModelList));
    });

    return null;
  }
}

class SetObserverListObserverAction extends ReduxAction<AppState> {
  final List<ObserverModel> observerList;

  SetObserverListObserverAction({required this.observerList});
  @override
  AppState reduce() {
    observerList.sort((a, b) => a.id.compareTo(b.id));

    return state.copyWith(
      observerState: state.observerState.copyWith(
        observerList: observerList,
      ),
    );
  }

  void after() {
    if (state.observerState.observerCurrent != null) {
      dispatch(SetObserverCurrentObserverAction(
          id: state.observerState.observerCurrent!.id));
    }
  }
}

class SetObserverCurrentObserverAction extends ReduxAction<AppState> {
  final String id;
  SetObserverCurrentObserverAction({
    required this.id,
  });
  @override
  AppState reduce() {
    ObserverModel observerModel = ObserverModel(
      '',
      userFK: UserRef.fromMap({
        'id': state.userState.userCurrent!.id,
        'photoURL': state.userState.userCurrent!.photoURL,
        'displayName': state.userState.userCurrent!.displayName
      }),
      description: '',
      isDeleted: false,
    );
    if (id.isNotEmpty) {
      observerModel = state.observerState.observerList!
          .firstWhere((element) => element.id == id);
    }
    return state.copyWith(
      observerState: state.observerState.copyWith(
        observerCurrent: observerModel,
      ),
    );
  }

  void after() {
    dispatch(SetNulPhraseObserverAction());
  }
}

class SetNulPhraseObserverAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      observerState: state.observerState.copyWith(
        observerPhraseCurrentSetNull: true,
        observerPhraseListSetNull: true,
      ),
    );
  }
}

class CreateDocObserverAction extends ReduxAction<AppState> {
  final ObserverModel observerModel;

  CreateDocObserverAction({required this.observerModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(ObserverModel.collection);
    await docRef.add(observerModel.toMap());
    return null;
  }
}

class UpdateDocObserverAction extends ReduxAction<AppState> {
  final ObserverModel observerModel;

  UpdateDocObserverAction({required this.observerModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(ObserverModel.collection)
        .doc(observerModel.id);
    if (observerModel.isDeleted) {
      dispatch(GetDocsPhraseObservedAndSetNullObserverAction(
          observerId: observerModel.id));
    }
    dispatch(SetObserverCurrentObserverAction(id: ''));

    await docRef.update(observerModel.toMap());

    return null;
  }
}

class GetDocsPhraseObservedAndSetNullObserverAction
    extends ReduxAction<AppState> {
  final String observerId;

  GetDocsPhraseObservedAndSetNullObserverAction({required this.observerId});
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(PhraseModel.collection)
        .where('observer', isEqualTo: observerId);

    var futureQuerySnapshot = await collRef.get();
    var phraseIdList =
        futureQuerySnapshot.docs.map((docSnapshot) => docSnapshot.id).toList();
    for (var phraseId in phraseIdList) {
      dispatch(SetNullObserverFieldPhraseObserverAction(phraseId: phraseId));
    }
    return null;
  }
}

class SetNullObserverFieldPhraseObserverAction extends ReduxAction<AppState> {
  final String phraseId;

  SetNullObserverFieldPhraseObserverAction({required this.phraseId});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(PhraseModel.collection).doc(phraseId);
    await docRef.update({'observer': null});

    return null;
  }
}

class StreamDocsPhraseObserverAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(PhraseModel.collection)
        .where('observer', isEqualTo: state.observerState.observerCurrent!.id)
        .where('isDeleted', isEqualTo: false)
        .where('isArchived', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<PhraseModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                PhraseModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<PhraseModel> phraseModelList) {
      dispatch(SetObserverPhraseListObserverAction(
          observerPhraseList: phraseModelList));
    });

    return null;
  }
}

class SetObserverPhraseListObserverAction extends ReduxAction<AppState> {
  final List<PhraseModel> observerPhraseList;

  SetObserverPhraseListObserverAction({required this.observerPhraseList});
  @override
  AppState reduce() {
    observerPhraseList.sort((a, b) => a.phrase.compareTo(b.phrase));
    return state.copyWith(
      observerState: state.observerState.copyWith(
        observerPhraseList: observerPhraseList,
      ),
    );
  }

  void after() {
    if (state.observerState.observerPhraseCurrent != null) {
      dispatch(SetObserverPhraseCurrentObserverAction(
          id: state.observerState.observerPhraseCurrent!.id));
    }
  }
}

class SetObserverPhraseCurrentObserverAction extends ReduxAction<AppState> {
  final String id;
  SetObserverPhraseCurrentObserverAction({required this.id});
  @override
  AppState reduce() {
    PhraseModel phraseModel;
    phraseModel = state.observerState.observerPhraseList!
        .firstWhere((element) => element.id == id);

    return state.copyWith(
      observerState: state.observerState.copyWith(
        observerPhraseCurrent: phraseModel,
      ),
    );
  }
}
