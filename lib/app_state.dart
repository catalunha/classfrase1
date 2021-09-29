import 'package:async_redux/async_redux.dart';

import 'classification/controller/classification_state.dart';
import 'classifying/controller/classifying_state.dart';
import 'login/controller/login_state.dart';
import 'phrase/controller/phrase_state.dart';
import 'user/controller/user_state.dart';

class AppState {
  final Wait wait;
  final LoginState loginState;
  final UserState userState;
  final PhraseState phraseState;
  final ClassifyingState classifyingState;
  final ClassificationState classificationState;

  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.phraseState,
    required this.classifyingState,
    required this.classificationState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        phraseState: PhraseState.initialState(),
        classifyingState: ClassifyingState.initialState(),
        classificationState: ClassificationState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    PhraseState? phraseState,
    ClassifyingState? classifyingState,
    ClassificationState? classificationState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      phraseState: phraseState ?? this.phraseState,
      classifyingState: classifyingState ?? this.classifyingState,
      classificationState: classificationState ?? this.classificationState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.classificationState == classificationState &&
        other.classifyingState == classifyingState &&
        other.phraseState == phraseState &&
        other.loginState == loginState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return phraseState.hashCode ^
        classificationState.hashCode ^
        classifyingState.hashCode ^
        loginState.hashCode ^
        userState.hashCode ^
        wait.hashCode;
  }
}
