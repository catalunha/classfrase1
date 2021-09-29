import 'dart:async';

import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';

class SetPhraseListClassifyingAction extends ReduxAction<AppState> {
  @override
  AppState reduce() {
    List<String> phraseList =
        state.phraseState.phraseCurrent!.phrase.split(' ');
    return state.copyWith(
      classifyingState: state.classifyingState.copyWith(
        phraseList: phraseList,
      ),
    );
  }
}

class SetSelectedPhrasePosClassifyingAction extends ReduxAction<AppState> {
  final int phrasePos;

  SetSelectedPhrasePosClassifyingAction({required this.phrasePos});
  @override
  AppState reduce() {
    List<int> phraseSelectedList =
        state.classifyingState.selectedPhrasePosList!;
    if (phraseSelectedList.contains(phrasePos)) {
      phraseSelectedList.remove(phrasePos);
    } else {
      phraseSelectedList.add(phrasePos);
    }
    print(phraseSelectedList.length);
    return state.copyWith(
      classifyingState: state.classifyingState.copyWith(
        selectedPhrasePosList: phraseSelectedList,
      ),
    );
  }
}
