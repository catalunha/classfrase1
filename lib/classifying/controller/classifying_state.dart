import 'package:flutter/foundation.dart';

class ClassifyingState {
  final List<String>? phraseList;
  final List<int>? selectedPhrasePosList;

  ClassifyingState({
    this.phraseList,
    this.selectedPhrasePosList,
  });
  factory ClassifyingState.initialState() => ClassifyingState(
        phraseList: [],
        selectedPhrasePosList: [],
      );
  ClassifyingState copyWith({
    List<String>? phraseList,
    List<int>? selectedPhrasePosList,
  }) {
    return ClassifyingState(
      phraseList: phraseList ?? this.phraseList,
      selectedPhrasePosList:
          selectedPhrasePosList ?? this.selectedPhrasePosList,
    );
  }

  @override
  String toString() =>
      'ClassifyingState(phraseList: $phraseList, phraseSelected: $selectedPhrasePosList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassifyingState &&
        listEquals(other.phraseList, phraseList) &&
        listEquals(other.selectedPhrasePosList, selectedPhrasePosList);
  }

  @override
  int get hashCode => phraseList.hashCode ^ selectedPhrasePosList.hashCode;
}
