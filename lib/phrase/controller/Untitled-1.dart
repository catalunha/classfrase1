// import 'package:async_redux/async_redux.dart';
// import 'package:classfrase/user/controller/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../app_state.dart';
// import 'phrase_model.dart';

// class StreamDocsPhraseAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     //print('--> StreamDocsResourceAction');
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     Query<Map<String, dynamic>> collRef;
//     collRef = firebaseFirestore
//         .collection(PhraseModel.collection)
//         .where('userRef.id', isEqualTo: state.userState.userCurrent!.id)
//         .where('isDeleted', isEqualTo: false)
//         .where('isArchived', isEqualTo: false);

//     Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
//         collRef.snapshots();

//     Stream<List<PhraseModel>> streamList = streamQuerySnapshot.map(
//         (querySnapshot) => querySnapshot.docs
//             .map((docSnapshot) =>
//                 PhraseModel.fromMap(docSnapshot.id, docSnapshot.data()))
//             .toList());
//     streamList.listen((List<PhraseModel> phraseModelList) {
//       dispatch(SetPhraseListPhraseAction(phraseList: phraseModelList));
//     });

//     return null;
//   }
// }

// class ReadDocsPhraseAction extends ReduxAction<AppState> {
//   final bool isArchived;

//   ReadDocsPhraseAction({required this.isArchived});
//   @override
//   Future<AppState?> reduce() async {
//     //print('--> ReadDocsPhraseAction');
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
//         .collection(PhraseModel.collection)
//         .where('userRef.id', isEqualTo: state.userState.userCurrent!.id)
//         .where('isDeleted', isEqualTo: false)
//         .where('isArchived', isEqualTo: isArchived)
//         .get();
//     List<PhraseModel> phraseModelList = [];
//     phraseModelList = querySnapshot.docs
//         .map(
//           (queryDocumentSnapshot) => PhraseModel.fromMap(
//             queryDocumentSnapshot.id,
//             queryDocumentSnapshot.data(),
//           ),
//         )
//         .toList();
//     dispatch(SetPhraseArchivedListPhraseAction(phraseList: phraseModelList));
//     return null;
//   }
// }

// class SetPhraseListPhraseAction extends ReduxAction<AppState> {
//   final List<PhraseModel> phraseList;

//   SetPhraseListPhraseAction({required this.phraseList});
//   @override
//   AppState reduce() {
//     return state.copyWith(
//       phraseState: state.phraseState.copyWith(
//         phraseList: phraseList,
//       ),
//     );
//   }

//   void after() {
//     if (state.phraseState.phraseCurrent != null) {
//       dispatch(SetPhraseCurrentPhraseAction(
//           id: state.phraseState.phraseCurrent!.id));
//     }
//   }
// }

// class SetPhraseArchivedListPhraseAction extends ReduxAction<AppState> {
//   final List<PhraseModel> phraseList;

//   SetPhraseArchivedListPhraseAction({required this.phraseList});
//   @override
//   AppState reduce() {
//     return state.copyWith(
//       phraseState: state.phraseState.copyWith(
//         phraseArchivedList: phraseList,
//       ),
//     );
//   }
// }

// class SetPhraseCurrentPhraseAction extends ReduxAction<AppState> {
//   final String? id;
//   SetPhraseCurrentPhraseAction({
//     required this.id,
//   });
//   @override
//   AppState reduce() {
//     print('--> SetPhraseCurrentPhraseAction: id=${id ?? "null"}');
//     PhraseModel phraseModel;
//     if (id == null) {
//       print('--> SetPhraseCurrentPhraseAction: id==null');

//       return state.copyWith(
//         phraseState: state.phraseState.copyWith(
//           phraseCurrentSetNull: true,
//         ),
//       );
//     } else if (id == '') {
//       phraseModel = PhraseModel(
//         '',
//         userFK: UserRef.fromMap({
//           'id': state.userState.userCurrent!.id,
//           'photoURL': state.userState.userCurrent!.photoURL,
//           'displayName': state.userState.userCurrent!.displayName
//         }),
//         phrase: '',
//         classifications: <String, Classification>{},
//       );
//     } else {
//       // int index = state.phraseState.phraseList!
//       //     .indexWhere((element) => element.id == id);
//       // if (index > 0) {
//       phraseModel = state.phraseState.phraseList!
//           .firstWhere((element) => element.id == id);
//       // } else {
//       //   return state.copyWith(
//       //     phraseState: state.phraseState.copyWith(
//       //       phraseCurrentSetNull: true,
//       //     ),
//       //   );
//       // }
//     }
//     // PhraseModel phraseModel = PhraseModel(
//     //   '',
//     //   userFK: UserRef.fromMap({
//     //     'id': state.userState.userCurrent!.id,
//     //     'photoURL': state.userState.userCurrent!.photoURL,
//     //     'displayName': state.userState.userCurrent!.displayName
//     //   }),
//     //   phrase: '',
//     //   classifications: <String, Classification>{},
//     // );
//     // if (id.isNotEmpty) {
//     //   phraseModel = state.phraseState.phraseList!
//     //       .firstWhere((element) => element.id == id);
//     // }
//     return state.copyWith(
//       phraseState: state.phraseState.copyWith(
//         phraseCurrent: phraseModel,
//       ),
//     );
//   }
// }

// class CreateDocPhraseAction extends ReduxAction<AppState> {
//   final PhraseModel phraseModel;

//   CreateDocPhraseAction({required this.phraseModel});

//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     CollectionReference docRef =
//         firebaseFirestore.collection(PhraseModel.collection);
//     await docRef.add(phraseModel.toMap());
//     return null;
//   }
// }

// class UpdateDocPhraseAction extends ReduxAction<AppState> {
//   final PhraseModel phraseModel;

//   UpdateDocPhraseAction({required this.phraseModel});

//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     DocumentReference docRef = firebaseFirestore
//         .collection(PhraseModel.collection)
//         .doc(phraseModel.id);
//     PhraseModel phraseModelOld = state.phraseState.phraseCurrent!;
//     print('UpdateDocPhraseAction: 1');
//     // dispatch(SetPhraseCurrentPhraseAction(id: null));

//     await docRef.update(phraseModel.toMap());
//     if (phraseModel.phrase != phraseModelOld.phrase) {
//       await docRef.update({'classifications': <String, dynamic>{}});
//     }
//     print('UpdateDocPhraseAction: 2');

//     return null;
//   }

//   void after() {
//     print('UpdateDocPhraseAction: after');
//     // dispatch(SetPhraseCurrentPhraseAction(id: null));
//   }
// }

// class UnArchivePhraseAction extends ReduxAction<AppState> {
//   final String phraseId;

//   UnArchivePhraseAction({required this.phraseId});

//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     DocumentReference docRef =
//         firebaseFirestore.collection(PhraseModel.collection).doc(phraseId);

//     await docRef.update({'isArchived': false});

//     return null;
//   }
// }
