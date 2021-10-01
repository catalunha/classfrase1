import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../app_state.dart';
import 'classification_model.dart';

class CreateDocClassificationAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(ClassificationModel.collection);

    Map<String, ClassGroup> classGroup = <String, ClassGroup>{};
    classGroup['720c16e8-f119-44b8-82dd-80ade6e2feae'] = ClassGroup(
      title: 'Morfométrica',
      url:
          'https://docs.google.com/document/d/11nqQ3tZTghRU7i43XR8tvcHrOMdWwnODnJbvxZtqF9c/edit?usp=sharing',
    );
    classGroup['fcb86ff1-859e-465b-8b9c-2ee88ebe84cc'] = ClassGroup(
      title: 'Sintática',
      url:
          'https://docs.google.com/document/d/11nqQ3tZTghRU7i43XR8tvcHrOMdWwnODnJbvxZtqF9c/edit?usp=sharing',
    );
    Map<String, ClassCategory> category = <String, ClassCategory>{};
    category['38f29fbd-5654-4ec7-b4fd-9b3260587f9d'] = ClassCategory(
        type: '720c16e8-f119-44b8-82dd-80ade6e2feae',
        title: 'Substantivo',
        url:
            'https://docs.google.com/document/d/1PNXD4OoaaOM60Xt4C8WaMOT3uV3FNhlL3xXSIpnH2LE/edit?usp=sharing');
    category['eb613d91-f3c0-478c-9bed-14e0fd6c92b1'] = ClassCategory(
      type: '720c16e8-f119-44b8-82dd-80ade6e2feae',
      title: 'Substantivo-Comum',
      url:
          'https://docs.google.com/document/d/11nqQ3tZTghRU7i43XR8tvcHrOMdWwnODnJbvxZtqF9c/edit?usp=sharing',
    );
    category['d81cee40-1e1c-439b-a9b5-7104bfaba6c2'] = ClassCategory(
      type: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
      title: 'Sujeito',
      url:
          'https://docs.google.com/document/d/11nqQ3tZTghRU7i43XR8tvcHrOMdWwnODnJbvxZtqF9c/edit?usp=sharing',
    );

    ClassificationModel classificationModel =
        ClassificationModel('', category: category, group: classGroup);

    await docRef.add(classificationModel.toMap());
    return null;
  }
}

class ReadDocClassificationAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    print('--> ReadDocsPhraseAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documentReference =
        await firebaseFirestore
            .collection(ClassificationModel.collection)
            .doc('RPFmVuPwksM8YhOVRCVn')
            .get();
    ClassificationModel classificationModel = ClassificationModel.fromMap(
      documentReference.id,
      documentReference.data()!,
    );

    dispatch(SetClassificationAction(classification: classificationModel));
    return null;
  }
}

class SetClassificationAction extends ReduxAction<AppState> {
  final ClassificationModel classification;

  SetClassificationAction({required this.classification});
  @override
  AppState reduce() {
    return state.copyWith(
      classifyingState: state.classifyingState.copyWith(
        classificationCurrent: classification,
      ),
    );
  }
}
