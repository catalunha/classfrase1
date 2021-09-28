import 'package:async_redux/async_redux.dart';

import 'login/controller/login_state.dart';
import 'phrase/controller/phrase_state.dart';
import 'user/controller/user_state.dart';

class AppState {
  final Wait wait;
  final LoginState loginState;
  final UserState userState;
  final PhraseState phraseState;

  AppState({
    required this.wait,
    required this.loginState,
    required this.userState,
    required this.phraseState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        loginState: LoginState.initialState(),
        userState: UserState.initialState(),
        phraseState: PhraseState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    LoginState? loginState,
    UserState? userState,
    PhraseState? phraseState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      loginState: loginState ?? this.loginState,
      userState: userState ?? this.userState,
      phraseState: phraseState ?? this.phraseState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.phraseState == phraseState &&
        other.loginState == loginState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return phraseState.hashCode ^
        loginState.hashCode ^
        userState.hashCode ^
        wait.hashCode;
  }
}
