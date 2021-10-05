import 'classification_model.dart';

class ClassificationState {
  final ClassificationModel? classificationCurrent;
  final ClassGroup? groupCurrent;
  final ClassCategory? categoryCurrent;
  ClassificationState({
    this.classificationCurrent,
    this.groupCurrent,
    this.categoryCurrent,
  });
  factory ClassificationState.initialState() => ClassificationState(
        classificationCurrent: null,
        groupCurrent: null,
        categoryCurrent: null,
      );
  ClassificationState copyWith({
    ClassificationModel? classificationCurrent,
    ClassGroup? groupCurrent,
    ClassCategory? categoryCurrent,
  }) {
    return ClassificationState(
      classificationCurrent:
          classificationCurrent ?? this.classificationCurrent,
      groupCurrent: groupCurrent ?? this.groupCurrent,
      categoryCurrent: categoryCurrent ?? this.categoryCurrent,
    );
  }

  @override
  String toString() =>
      'ClassificationState(classificationCurrent: $classificationCurrent)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassificationState &&
        other.groupCurrent == groupCurrent &&
        other.categoryCurrent == categoryCurrent &&
        other.classificationCurrent == classificationCurrent;
  }

  @override
  int get hashCode =>
      groupCurrent.hashCode ^
      categoryCurrent.hashCode ^
      classificationCurrent.hashCode;
}
