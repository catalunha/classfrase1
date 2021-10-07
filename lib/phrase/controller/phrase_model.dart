import 'dart:convert';

import 'package:classfrase/user/controller/user_model.dart';
import 'package:flutter/foundation.dart';

import 'package:classfrase/firestore/firestore_model.dart';

class PhraseModel extends FirestoreModel {
  static final String collection = 'phrases';

  final UserRef userFK;
  final String phrase;
  List<String>? phraseList;
  final String? font;
  final String? description;
  final bool isArchived;
  final bool isPublic;
  final String? observer;

  final Map<String, Classification> classifications;
  final bool isDeleted;
  PhraseModel(
    String id, {
    required this.userFK,
    required this.phrase,
    this.font = '',
    this.description = '',
    this.isArchived = false,
    this.isPublic = false,
    this.observer = '',
    required this.classifications,
    this.isDeleted = false,
  }) : super(id);

  PhraseModel copyWith({
    UserRef? userRef,
    String? phrase,
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
      userFK: userRef ?? this.userFK,
      phrase: phrase ?? this.phrase,
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
    data["classifications"] = Map<String, dynamic>();
    for (var item in classifications.entries) {
      data["classifications"][item.key] = item.value.toMap();
    }

    data['userRef'] = userFK.toMap();
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
    var classificationsMapTemp = Map<String, Classification>();
    if (map["classifications"] is Map && map["classifications"] != null) {
      for (var item in map["classifications"].entries) {
        //print('item: ${item.key}');
        //print('item: ${item.value}');
        classificationsMapTemp[item.key] = Classification.fromMap(item.value);
      }
    }
    var temp = PhraseModel(
      id,
      userFK: UserRef.fromMap(map['userRef']),
      phrase: map['phrase'],
      font: map['font'],
      description: map['description'],
      isArchived: map['isArchived'],
      isPublic: map['isPublic'],
      observer: map['observer'],
      classifications: classificationsMapTemp,
      isDeleted: map['isDeleted'],
    );
    temp.setPhraseList();
    return temp;
  }

  String toJson() => json.encode(toMap());

  factory PhraseModel.fromJson(String id, String source) =>
      PhraseModel.fromMap(id, json.decode(source));

  setPhraseList() {
    String word = '';
    List<String> _phraseList = [];
    for (var i = 0; i < phrase.length; i++) {
      // print(
      //     '${phrase[i]} ${phrase[i].contains(RegExp(r"/^[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ ]+$/"))}');
      // print(
      //     '${phrase[i]} ${phrase[i].contains(RegExp(r"[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ]"))}');
      // print(
      //     '${phrase[i]} ${phrase[i].contains(RegExp(r"[A-Za-z\u00C0-\u00FF]"))}');
      if (phrase[i].contains(
          RegExp(r"[A-Za-záàâãéèêíïóôõöúçñÁÀÂÃÉÈÍÏÓÔÕÖÚÇÑ0123456789]"))) {
        word += phrase[i];
      } else {
        print(word);
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
    phraseList = _phraseList;
  }

  @override
  String toString() {
    return 'PhraseModel( phrase: $phrase, font: $font, description: $description, isArchived: $isArchived, isPublic: $isPublic, observer: $observer,  isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseModel &&
        other.userFK == userFK &&
        other.phrase == phrase &&
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
    return userFK.hashCode ^
        phrase.hashCode ^
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
