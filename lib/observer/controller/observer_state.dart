import 'package:classfrase/phrase/controller/phrase_model.dart';
import 'package:flutter/foundation.dart';
import 'observer_model.dart';

class ObserverState {
  final List<ObserverModel>? observerList;
  final ObserverModel? observerCurrent;
  final PhraseModel? observerPhraseCurrent;
  final List<PhraseModel>? observerPhraseList;
  ObserverState({
    this.observerCurrent,
    this.observerList,
    this.observerPhraseCurrent,
    this.observerPhraseList,
  });
  factory ObserverState.initialState() => ObserverState(
        observerCurrent: null,
        observerList: [],
        observerPhraseCurrent: null,
        observerPhraseList: [],
      );
  ObserverState copyWith({
    ObserverModel? observerCurrent,
    List<ObserverModel>? observerList,
    PhraseModel? observerPhraseCurrent,
    bool observerPhraseCurrentSetNull = false,
    List<PhraseModel>? observerPhraseList,
    bool observerPhraseListSetNull = false,
  }) {
    return ObserverState(
      observerCurrent: observerCurrent ?? this.observerCurrent,
      observerList: observerList ?? this.observerList,
      observerPhraseCurrent: observerPhraseCurrentSetNull
          ? null
          : observerPhraseCurrent ?? this.observerPhraseCurrent,
      observerPhraseList: observerPhraseListSetNull
          ? []
          : observerPhraseList ?? this.observerPhraseList,
    );
  }

  @override
  String toString() =>
      'PhraseState(observerCurrent: $observerCurrent, observerList: $observerList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ObserverState &&
        other.observerCurrent == observerCurrent &&
        other.observerPhraseCurrent == observerPhraseCurrent &&
        listEquals(other.observerList, observerList) &&
        listEquals(other.observerPhraseList, observerPhraseList);
  }

  @override
  int get hashCode =>
      observerPhraseCurrent.hashCode ^
      observerPhraseList.hashCode ^
      observerCurrent.hashCode ^
      observerList.hashCode;
}
