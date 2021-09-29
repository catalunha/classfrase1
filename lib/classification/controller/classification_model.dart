import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:classfrase/firestore/firestore_model.dart';

class ClassificationModel extends FirestoreModel {
  static final String collection = 'classifications';
  final Map<String, Group> group; // uuid:Type

  final Map<String, Category> category; // uuid:Category
  ClassificationModel(
    String id, {
    required this.group,
    required this.category,
  }) : super(id);

  ClassificationModel copyWith({
    Map<String, Group>? group,
    Map<String, Category>? category,
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
    var groupMapTemp = Map<String, Group>();
    if (map["group"] is Map && map["group"] != null) {
      for (var item in map["group"].entries) {
        groupMapTemp[item.key] = Group.fromMap(item.entries);
      }
    }
    var categoryTemp = Map<String, Category>();
    if (map["category"] is Map && map["category"] != null) {
      for (var item in map["category"].entries) {
        categoryTemp[item.key] = Category.fromMap(item.entries);
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

class Group {
  final String title;
  final String? url;
  Group({
    required this.title,
    this.url,
  });

  Group copyWith({
    String? title,
    String? url,
  }) {
    return Group(
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

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      title: map['title'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) => Group.fromMap(json.decode(source));

  @override
  String toString() => 'Group(title: $title, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Group && other.title == title && other.url == url;
  }

  @override
  int get hashCode => title.hashCode ^ url.hashCode;
}

class Category {
  final String type;
  final String title;
  final String? url;
  Category({
    required this.type,
    required this.title,
    this.url,
  });

  Category copyWith({
    String? type,
    String? title,
    String? url,
  }) {
    return Category(
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

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      type: map['type'],
      title: map['title'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  String toString() => 'Category(type: $type, title: $title, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Category &&
        other.type == type &&
        other.title == title &&
        other.url == url;
  }

  @override
  int get hashCode => type.hashCode ^ title.hashCode ^ url.hashCode;
}
