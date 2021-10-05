import 'package:flutter/foundation.dart';

class ClassifyingState {
  // final ClassificationModel? classificationModel;
  // final List<String>? phraseList;
  final List<int>? selectedPosPhraseList;
  final List<String>? selectedCategoryIdList;

  ClassifyingState({
    // this.classificationModel,
    // this.phraseList,
    this.selectedPosPhraseList,
    this.selectedCategoryIdList,
  });
  factory ClassifyingState.initialState() => ClassifyingState(
        // classificationModel: null,
        // phraseList: [],
        selectedPosPhraseList: [],
        selectedCategoryIdList: [],
      );
  ClassifyingState copyWith({
    // ClassificationModel? classificationCurrent,
    List<String>? phraseList,
    List<int>? selectedPhrasePosList,
    bool selectedPhrasePosListSetNull = false,
    List<String>? selectedCategoryIdList,
    bool selectedCategoryIdListSetNull = false,
  }) {
    return ClassifyingState(
      // phraseList: phraseList ?? this.phraseList,
      selectedCategoryIdList: selectedCategoryIdListSetNull
          ? []
          : selectedCategoryIdList ?? this.selectedCategoryIdList,
      selectedPosPhraseList: selectedPhrasePosListSetNull
          ? []
          : selectedPhrasePosList ?? this.selectedPosPhraseList,
      // classificationModel: classificationCurrent ?? this.classificationModel,
    );
  }

  @override
  String toString() =>
      'ClassifyingState( phraseSelected: $selectedPosPhraseList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassifyingState &&
        // other.classificationModel == classificationModel &&
        listEquals(other.selectedPosPhraseList, selectedPosPhraseList) &&
        // listEquals(other.phraseList, phraseList) &&
        listEquals(other.selectedPosPhraseList, selectedPosPhraseList);
  }

  @override
  int get hashCode =>
      selectedPosPhraseList.hashCode ^
      // classificationModel.hashCode ^
      // phraseList.hashCode ^
      selectedPosPhraseList.hashCode;
}
