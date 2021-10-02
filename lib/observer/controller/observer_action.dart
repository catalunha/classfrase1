import 'package:async_redux/async_redux.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_state.dart';
import 'observer_model.dart';

class StreamDocsObserverAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> StreamDocsObserverAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(ObserverModel.collection)
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
    print('--> SetObserverCurrentObserverAction $id');
    ObserverModel observerModel = ObserverModel(
      '',
      description: '',
      phraseIdList: [],
      isDeleted: false,
      isBlocked: false,
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
    await docRef.update(observerModel.toMap());

    return null;
  }
}

class StreamDocsPhraseObserverAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> StreamDocsPhraseObserverAction');
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
    print('--> SetObserverPhraseCurrentObserverAction');
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
