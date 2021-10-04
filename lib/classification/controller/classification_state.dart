import 'classification_model.dart';

class ClassificationState {
  final ClassificationModel? classificationCurrent;
  ClassificationState({
    this.classificationCurrent,
  });
  factory ClassificationState.initialState() => ClassificationState(
        classificationCurrent: null,
      );
  ClassificationState copyWith({
    ClassificationModel? classificationCurrent,
  }) {
    return ClassificationState(
      classificationCurrent:
          classificationCurrent ?? this.classificationCurrent,
    );
  }

  @override
  String toString() =>
      'ClassificationState(classificationCurrent: $classificationCurrent)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassificationState &&
        other.classificationCurrent == classificationCurrent;
  }

  @override
  int get hashCode => classificationCurrent.hashCode;
}
