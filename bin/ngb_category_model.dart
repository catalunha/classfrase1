import 'dart:convert';

class NgbCategory {
  final String id;
  final String title;
  final String group;
  final String? description;
  final List<String>? filter;
  final String? url;
  NgbCategory({
    required this.id,
    required this.title,
    required this.group,
    this.description,
    this.filter,
    this.url,
  });

  NgbCategory copyWith({
    String? id,
    String? title,
    String? group,
    String? description,
    List<String>? filter,
    String? url,
  }) {
    return NgbCategory(
      id: id ?? this.id,
      title: title ?? this.title,
      group: group ?? this.group,
      description: description ?? this.description,
      filter: filter ?? this.filter,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'group': group,
      'description': description,
      'filter': filter,
      'url': url,
    };
  }

  factory NgbCategory.fromMap(Map<String, dynamic> map) {
    return NgbCategory(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      group: map['group'] ?? '',
      description: map['description'],
      filter: List<String>.from(map['filter']),
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NgbCategory.fromJson(String source) =>
      NgbCategory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NgbCategory(id: $id, title: $title, group: $group, description: $description, filter: $filter, url: $url)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is NgbCategory &&
  //       other.id == id &&
  //       other.title == title &&
  //       other.group == group &&
  //       other.description == description &&
  //       listEquals(other.filter, filter) &&
  //       other.url == url;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //       title.hashCode ^
  //       group.hashCode ^
  //       description.hashCode ^
  //       filter.hashCode ^
  //       url.hashCode;
  // }
}
