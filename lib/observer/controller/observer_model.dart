import 'dart:convert';

import 'package:classfrase/firestore/firestore_model.dart';
import 'package:classfrase/user/controller/user_model.dart';

class ObserverModel extends FirestoreModel {
  static final String collection = 'observers';
  final UserRef userFK;
  final String description;
  final bool isDeleted;
  ObserverModel(
    String id, {
    required this.userFK,
    required this.description,
    required this.isDeleted,
  }) : super(id);

  ObserverModel copyWith({
    UserRef? userFK,
    String? description,
    List<String>? phraseIdList,
    bool? isDeleted,
  }) {
    return ObserverModel(
      id,
      userFK: userFK ?? this.userFK,
      description: description ?? this.description,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userRef'] = userFK.toMap();
    data['description'] = description;
    data['isDeleted'] = isDeleted;
    return data;
  }

  factory ObserverModel.fromMap(String id, Map<String, dynamic> map) {
    return ObserverModel(
      id,
      userFK: UserRef.fromMap(map['userRef']),
      description: map['description'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ObserverModel.fromJson(String id, String source) =>
      ObserverModel.fromMap(id, json.decode(source));

  @override
  String toString() =>
      'ObserverModel(description: $description, isDeleted: $isDeleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ObserverModel &&
        other.userFK == userFK &&
        other.description == description &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode =>
      userFK.hashCode ^ description.hashCode ^ isDeleted.hashCode;
}
