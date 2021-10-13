import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:classfrase/follow/controller/follow_model.dart';
import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:classfrase/user/controller/user_model.dart';

class FollowState {
  final List<FollowModel>? followList;
  final FollowModel? followCurrent;
  // final List<UserRef>? userRefList;
  final UserRef? userRefCurrent;
  final List<PhraseModel>? phraseList;
  final PhraseModel? phraseCurrent;
  FollowState({
    this.followList,
    this.followCurrent,
    // this.userRefList,
    this.userRefCurrent,
    this.phraseList,
    this.phraseCurrent,
  });
  factory FollowState.initialState() => FollowState(
        followList: [],
        followCurrent: null,
        // userRefList: [],
        userRefCurrent: null,
        phraseList: [],
        phraseCurrent: null,
      );

  FollowState copyWith({
    List<FollowModel>? followList,
    FollowModel? followCurrent,
    // List<UserRef>? userRefList,
    // bool userRefListSetNull = false,
    UserRef? userRefCurrent,
    bool userRefCurrentSetNull = false,
    List<PhraseModel>? phraseList,
    bool phraseListSetNull = false,
    PhraseModel? phraseCurrent,
    bool phraseCurrentSetNull = false,
  }) {
    return FollowState(
      followList: followList ?? this.followList,
      followCurrent: followCurrent ?? this.followCurrent,
      // // userRefList: userRefListSetNull ? [] : userRefList ?? this.userRefList,
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

    return other is FollowState &&
        listEquals(other.followList, followList) &&
        other.followCurrent == followCurrent &&
        // listEquals(other.userRefList, userRefList) &&
        other.userRefCurrent == userRefCurrent &&
        listEquals(other.phraseList, phraseList) &&
        other.phraseCurrent == phraseCurrent;
  }

  @override
  int get hashCode {
    return followList.hashCode ^
        followCurrent.hashCode ^
        // userRefList.hashCode ^
        userRefCurrent.hashCode ^
        phraseList.hashCode ^
        phraseCurrent.hashCode;
  }
}
