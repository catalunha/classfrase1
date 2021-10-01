import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:classfrase/firestore/firestore_model.dart';

class ClassificationModel extends FirestoreModel {
  static final String collection = 'classifications';

  /// final String title;
  /// final String? url;
  final Map<String, ClassGroup> group; // uuid:Type
  /// final String type;
  /// final String title;
  /// final String? url;
  final Map<String, ClassCategory> category; // uuid:Category

  ClassificationModel(
    String id, {
    required this.group,
    required this.category,
  }) : super(id);

  ClassificationModel copyWith({
    Map<String, ClassGroup>? group,
    Map<String, ClassCategory>? category,
  }) {
    return ClassificationModel(
      id,
      group: group ?? this.group,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["group"] = Map<String, dynamic>();
    for (var item in group.entries) {
      data["group"][item.key] = item.value.toMap();
    }
    data["category"] = Map<String, dynamic>();
    for (var item in category.entries) {
      data["category"][item.key] = item.value.toMap();
    }
    return data;
  }

  factory ClassificationModel.fromMap(String id, Map<String, dynamic> map) {
    var groupMapTemp = Map<String, ClassGroup>();
    if (map["group"] is Map && map["group"] != null) {
      for (var item in map["group"].entries) {
        groupMapTemp[item.key] = ClassGroup.fromMap(item.value);
      }
    }
    var categoryTemp = Map<String, ClassCategory>();
    if (map["category"] is Map && map["category"] != null) {
      for (var item in map["category"].entries) {
        print('item: ${item.key}');
        print('item: ${item.value}');
        categoryTemp[item.key] = ClassCategory.fromMap(item.value);
      }
    }
    var temp = ClassificationModel(
      id,
      group: groupMapTemp,
      category: categoryTemp,
    );
    return temp;
  }

  String toJson() => json.encode(toMap());

  factory ClassificationModel.fromJson(String id, String source) =>
      ClassificationModel.fromMap(id, json.decode(source));

  @override
  String toString() =>
      'ClassificationModel(group: $group, category: $category)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassificationModel &&
        mapEquals(other.group, group) &&
        mapEquals(other.category, category);
  }

  @override
  int get hashCode => group.hashCode ^ category.hashCode;
}

class ClassGroup {
  final String title;
  final String? url;
  ClassGroup({
    required this.title,
    this.url,
  });

  ClassGroup copyWith({
    String? title,
    String? url,
  }) {
    return ClassGroup(
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
    };
  }

  factory ClassGroup.fromMap(Map<String, dynamic> map) {
    return ClassGroup(
      title: map['title'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassGroup.fromJson(String source) =>
      ClassGroup.fromMap(json.decode(source));

  @override
  String toString() => 'Group(title: $title, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassGroup && other.title == title && other.url == url;
  }

  @override
  int get hashCode => title.hashCode ^ url.hashCode;
}

class ClassCategory {
  final String type;
  final String title;
  final String? url;
  ClassCategory({
    required this.type,
    required this.title,
    this.url,
  });

  ClassCategory copyWith({
    String? type,
    String? title,
    String? url,
  }) {
    return ClassCategory(
      type: type ?? this.type,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'title': title,
      'url': url,
    };
  }

  factory ClassCategory.fromMap(Map<String, dynamic> map) {
    return ClassCategory(
      type: map['type'],
      title: map['title'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassCategory.fromJson(String source) =>
      ClassCategory.fromMap(json.decode(source));

  @override
  String toString() => 'Category(type: $type, title: $title, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassCategory &&
        other.type == type &&
        other.title == title &&
        other.url == url;
  }

  @override
  int get hashCode => type.hashCode ^ title.hashCode ^ url.hashCode;
}
