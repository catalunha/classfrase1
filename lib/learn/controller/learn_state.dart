import 'package:flutter/foundation.dart';

import 'package:classfrase/learn/controller/learn_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/user/controller/user_model.dart';

class LearnState {
  final List<LearnModel>? learnList;
  final LearnModel? learnCurrent;
  final UserRef? userRefCurrent;
  final List<PhraseModel>? phraseList;
  final List<PhraseModel>? phraseFilteredList;
  final PhraseModel? phraseCurrent;
  LearnState({
    this.learnList,
    this.learnCurrent,
    this.userRefCurrent,
    this.phraseList,
    this.phraseFilteredList,
    this.phraseCurrent,
  });
  factory LearnState.initialState() => LearnState(
        learnList: [],
        learnCurrent: null,
        userRefCurrent: null,
        phraseList: [],
        phraseFilteredList: [],
        phraseCurrent: null,
      );

  LearnState copyWith({
    List<LearnModel>? learnList,
    LearnModel? learnCurrent,
    UserRef? userRefCurrent,
    bool userRefCurrentSetNull = false,
    List<PhraseModel>? phraseList,
    List<PhraseModel>? phraseFilteredList,
    bool phraseFilteredListSetNull = false,
    bool phraseListSetNull = false,
    PhraseModel? phraseCurrent,
    bool phraseCurrentSetNull = false,
  }) {
    return LearnState(
      learnList: learnList ?? this.learnList,
      learnCurrent: learnCurrent ?? this.learnCurrent,
      userRefCurrent:
          userRefCurrentSetNull ? null : userRefCurrent ?? this.userRefCurrent,
      phraseList: phraseListSetNull ? [] : phraseList ?? this.phraseList,
      phraseFilteredList: phraseFilteredListSetNull
          ? []
          : phraseFilteredList ?? this.phraseFilteredList,
      phraseCurrent:
          phraseCurrentSetNull ? null : phraseCurrent ?? this.phraseCurrent,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LearnState &&
        listEquals(other.learnList, learnList) &&
        other.learnCurrent == learnCurrent &&
        other.userRefCurrent == userRefCurrent &&
        listEquals(other.phraseList, phraseList) &&
        listEquals(other.phraseFilteredList, phraseFilteredList) &&
        other.phraseCurrent == phraseCurrent;
  }

  @override
  int get hashCode {
    return learnList.hashCode ^
        learnCurrent.hashCode ^
        userRefCurrent.hashCode ^
        phraseList.hashCode ^
        phraseFilteredList.hashCode ^
        phraseCurrent.hashCode;
  }
}
