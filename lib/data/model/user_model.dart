import 'dart:convert';

class UserModel {
  static final String collection = 'users';

  final String id;
  final String? photoURL;
  final String? displayName;
  final String email;
  final String uid;
  final bool isActive;
  final int publicPhraseQuota;

  UserModel({
    required this.id,
    required this.email,
    required this.uid,
    this.displayName,
    this.photoURL,
    required this.isActive,
    this.publicPhraseQuota = 14,
  });

  UserModel copyWith({
    String? displayName,
    String? email,
    String? uid,
    String? photoURL,
    bool? isActive,
    int? publicPhraseQuota,
  }) {
    return UserModel(
      id: id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      photoURL: photoURL ?? this.photoURL,
      isActive: isActive ?? this.isActive,
      publicPhraseQuota: publicPhraseQuota ?? this.publicPhraseQuota,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      displayName: map['displayName'],
      email: map['email'],
      uid: map['uid'],
      photoURL: map['photoURL'],
      isActive: map['isActive'],
      publicPhraseQuota: map['publicPhraseQuota'] ?? 14,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

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
  final String email;
  final String? photoURL;
  final String? displayName;
  UserRef({
    required this.id,
    required this.email,
    this.photoURL,
    this.displayName,
  });

  @override
  String toString() {
    return 'UserRef(id: $id, email: $email, photoURL: $photoURL, displayName: $displayName)';
  }
}
