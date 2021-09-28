import 'dart:convert';

import 'package:classfrase/firestore/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'users';
  final String? photoURL;
  final String? displayName;
  final String email;
  final bool isActive;

  UserModel(
    String id, {
    required this.email,
    required this.isActive,
    this.displayName,
    this.photoURL,
  }) : super(id);

  UserModel copyWith({
    String? displayName,
    String? email,
    String? photoURL,
    bool? isActive,
  }) {
    return UserModel(
      id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      isActive: isActive ?? this.isActive,
    );
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id,
      displayName: map['displayName'],
      email: map['email'],
      photoURL: map['photoURL'],
      isActive: map['isActive'],
    );
  }

  factory UserModel.fromJson(String id, String source) =>
      UserModel.fromMap(id, json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
      'isActive': isActive,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserModel(displayName: $displayName, email: $email, photoURL: $photoURL, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.isActive == isActive &&
        other.displayName == displayName &&
        other.email == email &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        isActive.hashCode ^
        email.hashCode ^
        photoURL.hashCode;
  }
}
