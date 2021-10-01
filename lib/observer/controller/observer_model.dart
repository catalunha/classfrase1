import 'dart:convert';

import 'package:classfrase/firestore/firestore_model.dart';
import 'package:flutter/foundation.dart';

class ObserverModel extends FirestoreModel {
  static final String collection = 'observers';
  final String description;
  final List<String> phraseIdList;
  final bool isDeleted;
  ObserverModel(
    String id, {
    required this.description,
    required this.phraseIdList,
    required this.isDeleted,
  }) : super(id);

  ObserverModel copyWith({
    String? description,
    List<String>? phraseIdList,
    bool? isDeleted,
  }) {
    return ObserverModel(
      id,
      description: description ?? this.description,
      phraseIdList: phraseIdList ?? this.phraseIdList,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'phraseIdList': phraseIdList,
      'isDeleted': isDeleted,
    };
  }

  factory ObserverModel.fromMap(String id, Map<String, dynamic> map) {
    return ObserverModel(
      id,
      description: map['description'],
      phraseIdList: List<String>.from(map['phraseIdList']),
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ObserverModel.fromJson(String id, String source) =>
      ObserverModel.fromMap(id, json.decode(source));

  @override
  String toString() =>
      'ObserverModel(description: $description, phraseIdList: $phraseIdList, isDeleted: $isDeleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ObserverModel &&
        other.description == description &&
        listEquals(other.phraseIdList, phraseIdList) &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode =>
      description.hashCode ^ phraseIdList.hashCode ^ isDeleted.hashCode;
}
