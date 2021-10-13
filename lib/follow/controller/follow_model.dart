import 'package:classfrase/firestore/firestore_model.dart';
import 'package:flutter/foundation.dart';

import 'package:classfrase/user/controller/user_model.dart';

class FollowModel extends FirestoreModel {
  static final String collection = 'follows';
  final UserRef userRef;
  final String description;

  /// [String] é UserId
  ///
  /// UserId:{id:UserId,photoUrl:'',displayName:''}
  final Map<String, UserRef> following;
  final bool isDeleted;
  FollowModel(
    String id, {
    required this.description,
    required this.userRef,
    required this.following,
    required this.isDeleted,
  }) : super(id);

  FollowModel copyWith({
    UserRef? userRef,
    String? description,
    Map<String, UserRef>? following,
    bool? isDeleted,
  }) {
    return FollowModel(
      id,
      userRef: userRef ?? this.userRef,
      description: description ?? this.description,
      following: following ?? this.following,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['userRef'] = userRef.toMap();
    data['description'] = description;

    data["following"] = Map<String, dynamic>();
    for (var item in following.entries) {
      data["following"][item.key] = item.value.toMap();
    }

    if (isDeleted != null) data['isDeleted'] = isDeleted;

    return data;
  }

  factory FollowModel.fromMap(String id, Map<String, dynamic> map) {
    var followingTemp = Map<String, UserRef>();
    for (var item in map["following"].entries) {
      followingTemp[item.key] = UserRef.fromMap(item.value);
    }

    return FollowModel(
      id,
      userRef: UserRef.fromMap(map['userRef']),
      description: map['description'],
      following: followingTemp,
      isDeleted: map['isDeleted'] ?? false,
    );
  }

  @override
  String toString() =>
      'FollowModel(userRef: $userRef, following: $following, isDeleted: $isDeleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FollowModel &&
        other.userRef == userRef &&
        other.description == description &&
        mapEquals(other.following, following) &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode =>
      description.hashCode ^
      userRef.hashCode ^
      following.hashCode ^
      isDeleted.hashCode;
}
