import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../../app_state.dart';
import 'package:uuid/uuid.dart';

// class SetPhraseListClassifyingAction extends ReduxAction<AppState> {
//   @override
//   AppState reduce() {
//     List<String> phraseList =
//         state.phraseState.phraseCurrent!.phrase.split(' ');
//     return state.copyWith(
//       classifyingState: state.classifyingState.copyWith(
//         phraseList: phraseList,
//       ),
//     );
//   }
// }

class SetSelectedPhrasePosClassifyingAction extends ReduxAction<AppState> {
  final int phrasePos;

  SetSelectedPhrasePosClassifyingAction({required this.phrasePos});
  @override
  AppState reduce() {
    List<int> phraseSelectedList =
        state.classifyingState.selectedPosPhraseList!;
    if (phraseSelectedList.contains(phrasePos)) {
      phraseSelectedList.remove(phrasePos);
    } else {
      phraseSelectedList.add(phrasePos);
    }
    //print(phraseSelectedList.length);
    return state.copyWith(
      classifyingState: state.classifyingState.copyWith(
        selectedPhrasePosList: phraseSelectedList,
      ),
    );
  }
}

class SetSelectedCategoryIdClassifyingAction extends ReduxAction<AppState> {
  final String categoryId;

  SetSelectedCategoryIdClassifyingAction({required this.categoryId});
  @override
  AppState reduce() {
    List<String> categorySelectedList =
        state.classifyingState.selectedCategoryIdList!;
    if (categorySelectedList.contains(categoryId)) {
      categorySelectedList.remove(categoryId);
    } else {
      categorySelectedList.add(categoryId);
    }
    //print(categoryId.length);
    return state.copyWith(
      classifyingState: state.classifyingState.copyWith(
        selectedCategoryIdList: categorySelectedList,
      ),
    );
  }
}

class UpdateClassificationsPhraseClassifyingAction
    extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    Map<String, Classification> classifications =
        state.phraseState.phraseCurrent!.classifications;
    List<int> posPhraseListNow = state.classifyingState.selectedPosPhraseList!;
    posPhraseListNow.sort();
    List<String> categoryIdListNow =
        state.classifyingState.selectedCategoryIdList!;
    String classificationsId = Uuid().v4();
    for (var classificationsItem in classifications.entries) {
      if (listEquals(
          classificationsItem.value.posPhraseList, posPhraseListNow)) {
        classificationsId = classificationsItem.key;
      }
    }

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(PhraseModel.collection)
        .doc(state.phraseState.phraseCurrent!.id);

    Classification classificationNew = Classification(
        posPhraseList: posPhraseListNow, categoryIdList: categoryIdListNow);
    if (classificationNew.categoryIdList.isEmpty) {
      await docRef
          .update({'classifications.$classificationsId': FieldValue.delete()});
    } else {
      await docRef.update(
          {'classifications.$classificationsId': classificationNew.toMap()});
    }

    return null;
  }

  void after() {
    dispatch(SetNullSelectedCategoryIdClassifyingAction());
    dispatch(SetNullSelectedPhrasePosClassifyingAction());
    dispatch(NavigateAction.pop());
  }
}

class SetNullSelectedCategoryIdClassifyingAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      classifyingState: state.classifyingState.copyWith(
        selectedCategoryIdListSetNull: true,
      ),
    );
  }
}

class SetNullSelectedPhrasePosClassifyingAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    return state.copyWith(
      classifyingState: state.classifyingState.copyWith(
        selectedPhrasePosListSetNull: true,
      ),
    );
  }
}

class UpdateExistCategoryInPosClassifyingAction extends ReduxAction<AppState> {
  final String groupId;

  UpdateExistCategoryInPosClassifyingAction({required this.groupId});
  @override
  AppState reduce() {
    //print('UpdateExistCategoryInPosClassifyingAction');
    Map<String, Classification> classifications =
        state.phraseState.phraseCurrent!.classifications;
    List<int> posPhraseListNow = state.classifyingState.selectedPosPhraseList!;
    posPhraseListNow.sort();
    List<String> categoryIdListNow = [];
    for (var classificationsItem in classifications.entries) {
      if (listEquals(
          classificationsItem.value.posPhraseList, posPhraseListNow)) {
        // Map<String, ClassCategory> categoryMap =
        //     state.classifyingState.classificationCurrent!.category;
        for (var categoryId in classificationsItem.value.categoryIdList) {
          // if (categoryMap[categoryId]!.type == groupId) {
          categoryIdListNow.add(categoryId);
          // }
        }
        break;
      }
    }
    //print('categoryIdListNow $categoryIdListNow');
    return state.copyWith(
      classifyingState: state.classifyingState.copyWith(
        selectedCategoryIdList: categoryIdListNow,
      ),
    );
  }
}

class UpdateClassOrderPhraseAction extends ReduxAction<AppState> {
  final List<String> classOrder;
  UpdateClassOrderPhraseAction({required this.classOrder});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(PhraseModel.collection)
        .doc(state.phraseState.phraseCurrent!.id);
    await docRef.update({'classOrder': classOrder.cast<dynamic>()});
    return null;
  }
}

// class UpdateClassificationClassifyingAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     //print(state.classifyingState.selectedPosPhraseList);
//     //print(state.classifyingState.selectedCategoryIdList);
//     Map<String, Classification> classifications =
//         state.phraseState.phraseCurrent!.classifications;
//     // //print(classification);
//     List<int> posPhraseListNow = state.classifyingState.selectedPosPhraseList!;
//     posPhraseListNow.sort();
//     // String phrasePos = phrasePosList.join(',');
//     List<String> categoryIdListNow =
//         state.classifyingState.selectedCategoryIdList!;
//     String newCategoryId = atualCategoryId;
//     if (classifications.containsKey(phrasePos)) {
//       newCategoryId = classification[phrasePos]! + ',' + atualCategoryId;
//     }
//     //print('phrasePos' + phrasePos);
//     //print('newCategoryId' + newCategoryId);
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     DocumentReference docRef = firebaseFirestore
//         .collection(PhraseModel.collection)
//         .doc(state.phraseState.phraseCurrent!.id);
//     await docRef.update({'classification.$phrasePos': newCategoryId});
//     return null;
//   }

//   void after() {
//     dispatch(ResetClassificationClassifyingAction());
//     dispatch(NavigateAction.pop());
//   }
// }