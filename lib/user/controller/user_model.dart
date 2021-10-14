import 'dart:convert';

import 'package:classfrase/firestore/firestore_model.dart';

class UserModel extends FirestoreModel {
  static final String collection = 'users';
  final String? photoURL;
  final String? displayName;
  final String email;
  final String uid;
  final bool isActive;
  final int publicPhraseQuota;

  UserModel(
    String id, {
    required this.email,
    required this.uid,
    this.displayName,
    this.photoURL,
    required this.isActive,
    this.publicPhraseQuota = 7,
  }) : super(id);

  UserModel copyWith({
    String? displayName,
    String? email,
    String? uid,
    String? photoURL,
    bool? isActive,
    int? publicPhraseQuota,
  }) {
    return UserModel(
      id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      photoURL: photoURL ?? this.photoURL,
      isActive: isActive ?? this.isActive,
      publicPhraseQuota: publicPhraseQuota ?? this.publicPhraseQuota,
    );
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id,
      displayName: map['displayName'],
      email: map['email'],
      uid: map['uid'],
      photoURL: map['photoURL'],
      isActive: map['isActive'],
      publicPhraseQuota: map['publicPhraseQuota'] ?? 7,
    );
  }

  factory UserModel.fromJson(String id, String source) =>
      UserModel.fromMap(id, json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'uid': uid,
      'photoURL': photoURL,
      'isActive': isActive,
      'publicPhraseQuota': publicPhraseQuota,
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
        other.publicPhraseQuota == publicPhraseQuota &&
        other.isActive == isActive &&
        other.displayName == displayName &&
        other.email == email &&
        other.uid == uid &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        isActive.hashCode ^
        publicPhraseQuota.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        photoURL.hashCode;
  }
}

class UserRef {
  final String id;
  final String? photoURL;
  final String? displayName;
  UserRef({
    required this.id,
    this.photoURL,
    this.displayName,
  });

  UserRef copyWith({
    String? id,
    String? photoURL,
    String? displayName,
  }) {
    return UserRef(
      id: id ?? this.id,
      photoURL: photoURL ?? this.photoURL,
      displayName: displayName ?? this.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoURL': photoURL,
      'displayName': displayName,
    };
  }

  factory UserRef.fromMap(Map<String, dynamic> map) {
    return UserRef(
      id: map['id'],
      photoURL: map['photoURL'],
      displayName: map['displayName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRef.fromJson(String source) =>
      UserRef.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserRef(id: $id, photoURL: $photoURL, displayName: $displayName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRef &&
        other.id == id &&
        other.photoURL == photoURL &&
        other.displayName == displayName;
  }

  @override
  int get hashCode => id.hashCode ^ photoURL.hashCode ^ displayName.hashCode;
}
