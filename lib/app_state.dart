import 'package:async_redux/async_redux.dart';

import 'classification/controller/classification_state.dart';
import 'classifying/controller/classifying_state.dart';
import 'observer/controller/observer_state.dart';
import 'phrase/controller/phrase_state.dart';
import 'user/controller/user_state.dart';

class AppState {
  final Wait wait;
  // final LoginState loginState;
  final UserState userState;
  final PhraseState phraseState;
  final ClassificationState classificationState;
  final ClassifyingState classifyingState;
  final ObserverState observerState;

  AppState({
    required this.wait,
    // required this.loginState,
    required this.userState,
    required this.phraseState,
    required this.classificationState,
    required this.classifyingState,
    required this.observerState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        // loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        phraseState: PhraseState.initialState(),
        classificationState: ClassificationState.initialState(),
        classifyingState: ClassifyingState.initialState(),
        observerState: ObserverState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    // LoginState? loginState,
    UserState? userState,
    PhraseState? phraseState,
    ClassificationState? classificationState,
    ClassifyingState? classifyingState,
    ObserverState? observerState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      // // // loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      phraseState: phraseState ?? this.phraseState,
      classificationState: classificationState ?? this.classificationState,
      classifyingState: classifyingState ?? this.classifyingState,
      observerState: observerState ?? this.observerState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.observerState == observerState &&
        other.classificationState == classificationState &&
        other.classifyingState == classifyingState &&
        other.phraseState == phraseState &&
        // // other.loginState == loginState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return phraseState.hashCode ^
        observerState.hashCode ^
        classificationState.hashCode ^
        classifyingState.hashCode ^
        // loginState.hashCode ^
        userState.hashCode ^
        wait.hashCode;
  }
}
