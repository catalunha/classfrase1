import 'package:flutter/foundation.dart';
import 'phrase_model.dart';

class PhraseState {
  final PhraseModel? phraseCurrent;
  final List<PhraseModel>? phraseList;
  PhraseState({
    this.phraseCurrent,
    this.phraseList,
  });
  factory PhraseState.initialState() => PhraseState(
        phraseCurrent: null,
        phraseList: [],
      );
  PhraseState copyWith({
    PhraseModel? phraseCurrent,
    List<PhraseModel>? phraseList,
  }) {
    return PhraseState(
      phraseCurrent: phraseCurrent ?? this.phraseCurrent,
      phraseList: phraseList ?? this.phraseList,
    );
  }

  @override
  String toString() =>
      'PhraseState(phraseCurrent: $phraseCurrent, phraseList: $phraseList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseState &&
        other.phraseCurrent == phraseCurrent &&
        listEquals(other.phraseList, phraseList);
  }

  @override
  int get hashCode => phraseCurrent.hashCode ^ phraseList.hashCode;
}
