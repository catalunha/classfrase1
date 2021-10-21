import 'package:flutter/foundation.dart';

class ClassifyingState {
  final List<int>? selectedPosPhraseList;
  final List<String>? selectedCategoryIdList;

  ClassifyingState({
    this.selectedPosPhraseList,
    this.selectedCategoryIdList,
  });
  factory ClassifyingState.initialState() => ClassifyingState(
        selectedPosPhraseList: [],
        selectedCategoryIdList: [],
      );
  ClassifyingState copyWith({
    List<String>? phraseList,
    List<int>? selectedPhrasePosList,
    bool selectedPhrasePosListSetNull = false,
    List<String>? selectedCategoryIdList,
    bool selectedCategoryIdListSetNull = false,
  }) {
    return ClassifyingState(
      selectedCategoryIdList: selectedCategoryIdListSetNull
          ? []
          : selectedCategoryIdList ?? this.selectedCategoryIdList,
      selectedPosPhraseList: selectedPhrasePosListSetNull
          ? []
          : selectedPhrasePosList ?? this.selectedPosPhraseList,
    );
  }

  @override
  String toString() =>
      'ClassifyingState( phraseSelected: $selectedPosPhraseList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassifyingState &&
        listEquals(other.selectedPosPhraseList, selectedPosPhraseList) &&
        listEquals(other.selectedPosPhraseList, selectedPosPhraseList);
  }

  @override
  int get hashCode =>
      selectedPosPhraseList.hashCode ^ selectedPosPhraseList.hashCode;
}
