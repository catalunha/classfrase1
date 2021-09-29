import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_state.dart';
import 'classification_model.dart';

class ReadDocClassificantionAction extends ReduxAction<AppState> {
  ReadDocClassificantionAction();
  @override
  Future<AppState?> reduce() async {
    print('--> ReadDocsPhraseAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documentReference =
        await firebaseFirestore
            .collection(ClassificationModel.collection)
            .doc('HcPYu4YGNnZ64rNNJqdZ')
            .get();
    ClassificationModel classificationModel = ClassificationModel.fromMap(
      documentReference.id,
      documentReference.data()!,
    );

    dispatch(SetClassificantionAction(classification: classificationModel));
    return null;
  }
}

class SetClassificantionAction extends ReduxAction<AppState> {
  final ClassificationModel classification;

  SetClassificantionAction({required this.classification});
  @override
  AppState reduce() {
    return state.copyWith(
      classificationState: state.classificationState.copyWith(
        classificationCurrent: classification,
      ),
    );
  }
}
