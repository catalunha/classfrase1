import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../app_state.dart';
import 'classification_model.dart';

class UpdateDocGroupClassificationAction extends ReduxAction<AppState> {
  final ClassGroup classGroup;

  UpdateDocGroupClassificationAction({
    required this.classGroup,
  });

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(ClassificationModel.collection)
        .doc(state.classificationState.classificationCurrent!.id);
    await docRef.update({'group.${classGroup.id}': classGroup.toMap()});

    return null;
  }
}

class UpdateDocCategoryClassificationAction extends ReduxAction<AppState> {
  final ClassCategory classCategory;

  UpdateDocCategoryClassificationAction({
    required this.classCategory,
  });

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(ClassificationModel.collection)
        .doc(state.classificationState.classificationCurrent!.id);
    ClassCategory classCategoryTemp = classCategory.copyWith(
        group: state.classificationState.groupCurrent!.id);
    await docRef.update(
        {'category.${classCategoryTemp.id}': classCategoryTemp.toMap()});

    return null;
  }
}

class StreamDocsClassificationAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    //print('--> StreamDocsResourceAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    // Query<Map<String, dynamic>> collRef;
    // collRef = firebaseFirestore
    //     .collection(ClassificationModel.collection)
    //     ;

    // Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
    //     collRef.doc('1fgurc4R9nuFrfExP0UI').snapshots();
    var streamDocSnapshot = firebaseFirestore
        .collection(ClassificationModel.collection)
        .doc('PRpWYm0wwqDdmFzBvKJ1');

    Stream<DocumentSnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        streamDocSnapshot.snapshots();

    var streamList = streamQuerySnapshot.map((docSnapshot) =>
        ClassificationModel.fromMap(docSnapshot.id, docSnapshot.data()!));
    streamList.listen((classification) {
      dispatch(SetClassificationAction(classification: classification));
    });

    return null;
  }
}

class ReadDocClassificationAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    //print('--> ReadDocsPhraseAction');
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentSnapshot<Map<String, dynamic>> documentReference =
        await firebaseFirestore
            .collection(ClassificationModel.collection)
            .doc('PRpWYm0wwqDdmFzBvKJ1')
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
      classificationState: state.classificationState.copyWith(
        classificationCurrent: classification,
      ),
    );
  }
}

class SetGroupCurrentClassificationAction extends ReduxAction<AppState> {
  final String id;
  SetGroupCurrentClassificationAction({
    required this.id,
  });
  @override
  AppState reduce() {
    var uuid = Uuid();
    var v4 = uuid.v4();
    ClassGroup group = ClassGroup(
      id: v4,
      title: '',
    );
    if (id.isNotEmpty) {
      group = state.classificationState.classificationCurrent!.group[id]!;
      group.copyWith(id: id);
    }
    return state.copyWith(
      classificationState: state.classificationState.copyWith(
        groupCurrent: group,
      ),
    );
  }
}

class SetCategoryCurrentClassificationAction extends ReduxAction<AppState> {
  final String id;
  SetCategoryCurrentClassificationAction({
    required this.id,
  });
  @override
  AppState reduce() {
    var uuid = Uuid();
    var v4 = uuid.v4();
    ClassCategory category = ClassCategory(
      id: v4,
      group: '',
      title: '',
    );
    if (id.isNotEmpty) {
      category = state.classificationState.classificationCurrent!.category[id]!;
      category.copyWith(id: id);
    }
    return state.copyWith(
      classificationState: state.classificationState.copyWith(
        categoryCurrent: category,
      ),
    );
  }
}
