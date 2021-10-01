import 'package:flutter/foundation.dart';
import 'observer_model.dart';

class ObserverState {
  final ObserverModel? observerCurrent;
  final List<ObserverModel>? observerList;
  ObserverState({
    this.observerCurrent,
    this.observerList,
  });
  factory ObserverState.initialState() => ObserverState(
        observerCurrent: null,
        observerList: [],
      );
  ObserverState copyWith({
    ObserverModel? observerCurrent,
    List<ObserverModel>? observerList,
  }) {
    return ObserverState(
      observerCurrent: observerCurrent ?? this.observerCurrent,
      observerList: observerList ?? this.observerList,
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
        listEquals(other.observerList, observerList);
  }

  @override
  int get hashCode => observerCurrent.hashCode ^ observerList.hashCode;
}
