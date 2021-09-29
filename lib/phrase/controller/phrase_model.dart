import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:classfrase/firestore/firestore_model.dart';

class PhraseModel extends FirestoreModel {
  static final String collection = 'phrases';

  final String userId;
  final String phrase;
  List<String>? phraseList;
  final String? font;
  final String? description;
  final bool isArchived;
  final bool isPublic;
  final String? observer;

  final Map<String, String>? classification;
  final bool isDeleted;
  PhraseModel(
    String id, {
    required this.userId,
    required this.phrase,
    // this.phraseList,
    this.font = '',
    this.description = '',
    this.isArchived = false,
    this.isPublic = false,
    this.observer = '',
    this.classification,
    this.isDeleted = false,
  }) : super(id);

  PhraseModel copyWith({
    String? userId,
    String? phrase,
    String? font,
    String? description,
    bool? isArchived,
    bool? isPublic,
    String? observer,
    Map<String, String>? classification,
    bool? isDeleted,
  }) {
    return PhraseModel(
      id,
      userId: userId ?? this.userId,
      phrase: phrase ?? this.phrase,
      font: font ?? this.font,
      description: description ?? this.description,
      isArchived: isArchived ?? this.isArchived,
      isPublic: isPublic ?? this.isPublic,
      observer: observer ?? this.observer,
      classification: classification ?? this.classification,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["classification"] = Map<String, dynamic>();
    for (var item in classification!.entries) {
      data["classification"][item.key] = item.value;
    }
    data['userId'] = userId;
    data['phrase'] = phrase;
    data['font'] = font;
    data['description'] = description;
    data['isArchived'] = isArchived;
    data['isPublic'] = isPublic;
    data['observer'] = observer;
    data['isDeleted'] = isDeleted;
    return data;
  }

  factory PhraseModel.fromMap(String id, Map<String, dynamic> map) {
    var classificationMapTemp = Map<String, String>();
    if (map["classification"] is Map && map["classification"] != null) {
      for (var item in map["classification"].entries) {
        classificationMapTemp[item.key] = item.value;
      }
    }
    var temp = PhraseModel(
      id,
      userId: map['userId'],
      phrase: map['phrase'],
      // phraseList: map['phrase'].split(' '),
      font: map['font'],
      description: map['description'],
      isArchived: map['isArchived'],
      isPublic: map['isPublic'],
      observer: map['observer'],
      classification: classificationMapTemp,
      isDeleted: map['isDeleted'],
    );
    temp.setPhraseList();
    return temp;
  }

  String toJson() => json.encode(toMap());

  factory PhraseModel.fromJson(String id, String source) =>
      PhraseModel.fromMap(id, json.decode(source));

  setPhraseList() {
    phraseList = phrase.split(' ');
  }

  @override
  String toString() {
    return 'PhraseModel(userId: $userId, phrase: $phrase, font: $font, description: $description, isArchived: $isArchived, isPublic: $isPublic, observer: $observer, classification: $classification, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseModel &&
        other.userId == userId &&
        other.phrase == phrase &&
        other.font == font &&
        other.description == description &&
        other.isArchived == isArchived &&
        other.isPublic == isPublic &&
        other.observer == observer &&
        mapEquals(other.classification, classification) &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        phrase.hashCode ^
        font.hashCode ^
        description.hashCode ^
        isArchived.hashCode ^
        isPublic.hashCode ^
        observer.hashCode ^
        classification.hashCode ^
        isDeleted.hashCode;
  }
}
