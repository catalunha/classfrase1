import 'package:async_redux/async_redux.dart';

import 'classification/controller/classification_state.dart';
import 'classifying/controller/classifying_state.dart';
import 'learn/controller/learn_state.dart';
import 'observer/controller/observer_state.dart';
import 'phrase/controller/phrase_state.dart';
import 'user/controller/user_state.dart';
import 'users/controller/users_state.dart';

class AppState {
  final Wait wait;
  final UserState userState;
  final PhraseState phraseState;
  final ClassifyingState classifyingState;
  final ObserverState observerState;
  final ClassificationState classificationState;
  final UsersState usersState;
  final LearnState learnState;

  AppState({
    required this.wait,
    required this.userState,
    required this.phraseState,
    required this.classificationState,
    required this.classifyingState,
    required this.observerState,
    required this.usersState,
    required this.learnState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        userState: UserState.initialState(),
        phraseState: PhraseState.initialState(),
        classificationState: ClassificationState.initialState(),
        classifyingState: ClassifyingState.initialState(),
        observerState: ObserverState.initialState(),
        usersState: UsersState.initialState(),
        learnState: LearnState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    UserState? userState,
    PhraseState? phraseState,
    ClassificationState? classificationState,
    ClassifyingState? classifyingState,
    ObserverState? observerState,
    UsersState? usersState,
    LearnState? learnState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      userState: userState ?? this.userState,
      phraseState: phraseState ?? this.phraseState,
      classificationState: classificationState ?? this.classificationState,
      classifyingState: classifyingState ?? this.classifyingState,
      observerState: observerState ?? this.observerState,
      usersState: usersState ?? this.usersState,
      learnState: learnState ?? this.learnState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.learnState == learnState &&
        other.observerState == observerState &&
        other.classificationState == classificationState &&
        other.classifyingState == classifyingState &&
        other.phraseState == phraseState &&
        other.usersState == usersState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return phraseState.hashCode ^
        observerState.hashCode ^
        classificationState.hashCode ^
        classifyingState.hashCode ^
        usersState.hashCode ^
        userState.hashCode ^
        wait.hashCode;
  }
}
