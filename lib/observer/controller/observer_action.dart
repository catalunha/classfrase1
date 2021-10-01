import 'package:async_redux/async_redux.dart';
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
