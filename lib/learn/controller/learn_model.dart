import 'package:classfrase/firestore/firestore_model.dart';
import 'package:flutter/foundation.dart';

import 'package:classfrase/user/controller/user_model.dart';

class LearnModel extends FirestoreModel {
  static final String collection = 'learns';
  final UserRef userRef;
  final String description;

  /// [String] é UserId
  ///
  /// UserId:{id:UserId,photoUrl:'',displayName:''}
  final Map<String, UserRef> learning;
  final bool isDeleted;
  LearnModel(
    String id, {
    required this.description,
    required this.userRef,
    required this.learning,
    required this.isDeleted,
  }) : super(id);

  LearnModel copyWith({
    UserRef? userRef,
    String? description,
    Map<String, UserRef>? learning,
    bool? isDeleted,
  }) {
    return LearnModel(
      id,
      userRef: userRef ?? this.userRef,
      description: description ?? this.description,
      learning: learning ?? this.learning,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['userRef'] = userRef.toMap();
    data['description'] = description;

    data["learning"] = Map<String, dynamic>();
    for (var item in learning.entries) {
      data["learning"][item.key] = item.value.toMap();
    }

    data['isDeleted'] = isDeleted;

    return data;
  }

  factory LearnModel.fromMap(String id, Map<String, dynamic> map) {
    var learningTemp = Map<String, UserRef>();
    for (var item in map["learning"].entries) {
      learningTemp[item.key] = UserRef.fromMap(item.value);
    }

    return LearnModel(
      id,
      userRef: UserRef.fromMap(map['userRef']),
      description: map['description'],
      learning: learningTemp,
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  @override
  String toString() =>
      'LearnModel(userRef: $userRef, learning: $learning, isDeleted: $isDeleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LearnModel &&
        other.userRef == userRef &&
        other.description == description &&
        mapEquals(other.learning, learning) &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode =>
      description.hashCode ^
      userRef.hashCode ^
      learning.hashCode ^
      isDeleted.hashCode;
}
