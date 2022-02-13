import 'dart:convert';

class NgbGroup {
  final String id;
  final String title;
  final String? description;
  final List<String>? filter;
  final String? url;
  NgbGroup({
    required this.id,
    required this.title,
    this.description,
    this.filter,
    this.url,
  });

  NgbGroup copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? filter,
    String? url,
  }) {
    return NgbGroup(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      filter: filter ?? this.filter,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'filter': filter,
      'url': url,
    };
  }

  factory NgbGroup.fromMap(Map<String, dynamic> map) {
    return NgbGroup(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      filter: map['filter'] != null ? List<String>.from(map['filter']) : null,
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NgbGroup.fromJson(String source) =>
      NgbGroup.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NgbGroup(id: $id, title: $title, description: $description, filter: $filter, url: $url)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;

  //   return other is NgbGroup &&
  //       other.id == id &&
  //       other.title == title &&
  //       other.description == description &&
  //       listEquals(other.filter, filter) &&
  //       other.url == url;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //       title.hashCode ^
  //       description.hashCode ^
  //       filter.hashCode ^
  //       url.hashCode;
  // }

}
