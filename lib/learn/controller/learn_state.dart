import 'package:flutter/foundation.dart';

import 'package:classfrase/learn/controller/learn_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/user/controller/user_model.dart';

class LearnState {
  final List<LearnModel>? learnList;
  final LearnModel? learnCurrent;
  final UserRef? userRefCurrent;
  final List<PhraseModel>? phraseList;
  final PhraseModel? phraseCurrent;
  LearnState({
    this.learnList,
    this.learnCurrent,
    this.userRefCurrent,
    this.phraseList,
    this.phraseCurrent,
  });
  factory LearnState.initialState() => LearnState(
        learnList: [],
        learnCurrent: null,
        userRefCurrent: null,
        phraseList: [],
        phraseCurrent: null,
      );

  LearnState copyWith({
    List<LearnModel>? learnList,
    LearnModel? learnCurrent,
    UserRef? userRefCurrent,
    bool userRefCurrentSetNull = false,
    List<PhraseModel>? phraseList,
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
        other.phraseCurrent == phraseCurrent;
  }

  @override
  int get hashCode {
    return learnList.hashCode ^
        learnCurrent.hashCode ^
        userRefCurrent.hashCode ^
        phraseList.hashCode ^
        phraseCurrent.hashCode;
  }
}
