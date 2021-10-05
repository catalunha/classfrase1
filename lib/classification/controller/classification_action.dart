import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../app_state.dart';
import 'classification_model.dart';

// class CreateDocClassificationAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     CollectionReference docRef =
//         firebaseFirestore.collection(ClassificationModel.collection);

//     Map<String, ClassGroup> group = <String, ClassGroup>{};
//     group['720c16e8-f119-44b8-82dd-80ade6e2feae'] = ClassGroup(
//       title: 'Morfológica',
//     );
//     group['fcb86ff1-859e-465b-8b9c-2ee88ebe84cc'] = ClassGroup(
//       title: 'Sintática',
//     );
//     // ========== Morfológica =========
//     Map<String, ClassCategory> category = <String, ClassCategory>{};
//     category['38f29fbd-5654-4ec7-b4fd-9b3260587f9d'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Substantivo');
//     category['eb613d91-f3c0-478c-9bed-14e0fd6c92b1'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Artigo');
//     category['47eb4fb0-bc3f-4dff-8e3a-9e3a9a13a538'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Numeral');
//     category['a8af2306-1bf8-41cf-b648-d710400ec679'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Pronome');
//     category['08096fbe-4e8a-47a1-bb0d-f37d8f51e2a5'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Verbo');
//     category['96d6c0a1-2513-4b1d-9d79-b5ac616b7926'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Adjetivo');
//     category['36ea9dbd-1b3d-482a-bb57-f8d1a291efbd'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Adverbio');
//     category['00451975-b8fa-4839-af27-536b991a3a46'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Preposição');
//     category['03e7be38-84a7-4a4f-a688-9ca8a0cfa4f9'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Conjunção');
//     category['1296e277-d888-4cb9-8dfd-c6c4084bb6b9'] = ClassCategory(
//         group: '720c16e8-f119-44b8-82dd-80ade6e2feae', title: 'Interjeição');

//     // ========== Sintática =========

//     category['96345139-cb63-4853-ab1a-d1ec908a9ffb'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc', title: 'Sujeito');
//     category['89eb1b1e-9212-4bf7-bc8a-731f9cd6c25b'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc', title: 'Predicado');
//     category['aa72c6c1-9b99-404f-8010-2a24e6648fbf'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc', title: 'Objeto direto');
//     category['8dbfedfa-81c9-45d1-9105-1314cafeb520'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
//         title: 'Objeto indireto');
//     category['369af9a8-e664-4c67-8983-273ef90f24b3'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
//         title: 'Agente da passiva');

//     category['059ab63e-f1a9-4470-8c25-1e27b3722373'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
//         title: 'Predicativo do sujeito');
//     category['176a0464-22fa-4094-8dc3-036d0cc8b753'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
//         title: 'Predicativo do objeto');
//     category['f8d31996-c274-418c-bf31-a289671293ce'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
//         title: 'Complemento nominal');
//     category['ab3e5fe7-a667-4c05-96ca-0616b585938e'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
//         title: 'Complemento verbal');
//     category['56a6a0f3-e39e-40c3-949a-f71edfa24dbb'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc', title: 'Aposto');
//     category['56a6a0f3-e39e-40c3-949a-f71edfa24dbb'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc', title: 'Vocativo');
//     category['78d81b79-1200-4af0-9e03-11744b36d6b9'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
//         title: 'Adjunto adnominal');
//     category['c5be7b34-557b-4641-b818-e6b7e3da612a'] = ClassCategory(
//         group: 'fcb86ff1-859e-465b-8b9c-2ee88ebe84cc',
//         title: 'Adjunto adverbial');

//     ClassificationModel classificationModel =
//         ClassificationModel('', category: category, group: group);

//     await docRef.add(classificationModel.toMap());
//     return null;
//   }
// }

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
