import 'dart:convert';

import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/foundation.dart';

import 'package:classfrase/firestore/firestore_model.dart';

class PhraseModel extends FirestoreModel {
  static final String collection = 'phrases';

  final UserRef userRef;
  final String phrase;
  final Map<String, Classification> classifications;
  List<String> phraseList;
  final String? font;
  final String? description;
  final String? observer;

  final bool isArchived;
  final bool isPublic;
  final bool isDeleted;
  PhraseModel(
    String id, {
    required this.userRef,
    required this.phrase,
    required this.classifications,
    required this.phraseList,
    this.isArchived = false,
    this.isPublic = false,
    this.isDeleted = false,
    this.font,
    this.description,
    this.observer,
  }) : super(id);

  PhraseModel copyWith({
    UserRef? userRef,
    String? phrase,
    List<String>? phraseList,
    String? font,
    String? description,
    bool? isArchived,
    bool? isPublic,
    String? observer,
    Map<String, Classification>? classifications,
    bool? isDeleted,
  }) {
    return PhraseModel(
      id,
      userRef: userRef ?? this.userRef,
      phrase: phrase ?? this.phrase,
      phraseList: phraseList ?? this.phraseList,
      font: font ?? this.font,
      description: description ?? this.description,
      isArchived: isArchived ?? this.isArchived,
      isPublic: isPublic ?? this.isPublic,
      observer: observer ?? this.observer,
      classifications: classifications ?? this.classifications,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userRef'] = userRef.toMap();
    data['phrase'] = phrase;
    data['phraseList'] = phraseList.cast<dynamic>();

    data["classifications"] = <String, dynamic>{};
    for (var item in classifications.entries) {
      data["classifications"][item.key] = item.value.toMap();
    }
    data['isArchived'] = isArchived;
    data['isPublic'] = isPublic;
    data['isDeleted'] = isDeleted;
    if (font != null) data['font'] = font;
    if (description != null) data['description'] = description;
    if (observer != null) data['observer'] = observer;
    return data;
  }

  factory PhraseModel.fromMap(String id, Map<String, dynamic> map) {
    Map<String, Classification>? _classifications = <String, Classification>{};
    if (map["classifications"] != null && map["classifications"] is Map) {
      _classifications = <String, Classification>{};
      for (var item in map["classifications"].entries) {
        _classifications[item.key] = Classification.fromMap(item.value);
      }
    }

    var temp = PhraseModel(
      id,
      userRef: UserRef.fromMap(map['userRef']),
      phrase: map['phrase'],
      classifications: _classifications,
      phraseList: map['phraseList'] == null
          ? setPhraseList(map['phrase'])
          : map['phraseList'].cast<String>(),
      isArchived: map['isArchived'],
      isPublic: map['isPublic'],
      isDeleted: map['isDeleted'],
      font: map['font'],
      description: map['description'],
      observer: map['observer'],
    );
    return temp;
  }

  String toJson() => json.encode(toMap());

  factory PhraseModel.fromJson(String id, String source) =>
      PhraseModel.fromMap(id, json.decode(source));

  static List<String> setPhraseList(String phrase) {
    print('-> Executando setPhraseList');
    String word = '';
    List<String> _phraseList = [];
    for (var i = 0; i < phrase.length; i++) {
      if (phrase[i].contains(RegExp(
          r"[A-Za-záàãâäÁÀÃÂÄéèêëÉÈÊËíìîïÍÌÎÏóòõôöÓÒÕÖÔúùûüÚÙÛÜçÇñÑ0123456789]"))) {
        word += phrase[i];
      } else {
        // print(word);
        if (word.isNotEmpty) {
          _phraseList.add(word);
          word = '';
        }
        _phraseList.add(phrase[i]);
      }
    }
    if (word.isNotEmpty) {
      _phraseList.add(word);
      word = '';
    }
    // print(phraseList);
    return _phraseList;
  }

  @override
  String toString() {
    return 'PhraseModel( phrase: $phrase, font: $font, description: $description, isArchived: $isArchived, isPublic: $isPublic, observer: $observer,  isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseModel &&
        other.userRef == userRef &&
        other.phrase == phrase &&
        other.phraseList == phraseList &&
        other.font == font &&
        other.description == description &&
        other.isArchived == isArchived &&
        other.isPublic == isPublic &&
        other.observer == observer &&
        mapEquals(other.classifications, classifications) &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return userRef.hashCode ^
        phrase.hashCode ^
        phraseList.hashCode ^
        font.hashCode ^
        description.hashCode ^
        isArchived.hashCode ^
        isPublic.hashCode ^
        observer.hashCode ^
        classifications.hashCode ^
        isDeleted.hashCode;
  }
}

class Classification {
  final List<int> posPhraseList;
  final List<String> categoryIdList;
  Classification({
    required this.posPhraseList,
    required this.categoryIdList,
  });

  Classification copyWith({
    List<int>? posPhraseList,
    List<String>? categoryIdList,
  }) {
    return Classification(
      posPhraseList: posPhraseList ?? this.posPhraseList,
      categoryIdList: categoryIdList ?? this.categoryIdList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'posPhraseList': posPhraseList,
      'categoryIdList': categoryIdList,
    };
  }

  factory Classification.fromMap(Map<String, dynamic> map) {
    return Classification(
      posPhraseList: List<int>.from(map['posPhraseList']),
      categoryIdList: List<String>.from(map['categoryIdList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Classification.fromJson(String source) =>
      Classification.fromMap(json.decode(source));

  @override
  String toString() =>
      'Classification(posPhraseList: $posPhraseList, categoryIdList: $categoryIdList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Classification &&
        listEquals(other.posPhraseList, posPhraseList) &&
        listEquals(other.categoryIdList, categoryIdList);
  }

  @override
  int get hashCode => posPhraseList.hashCode ^ categoryIdList.hashCode;
}
