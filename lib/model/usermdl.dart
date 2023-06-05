import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserMdl {
  String name;
  String email;
  String uId;
  UserMdl({
    required this.name,
    required this.email,
    required this.uId,
  });

  UserMdl copyWith({
    String? name,
    String? email,
    String? uId,
  }) {
    return UserMdl(
      name: name ?? this.name,
      email: email ?? this.email,
      uId: uId ?? this.uId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'uId': uId,
    };
  }

  factory UserMdl.fromMap(Map<String, dynamic> map) {
    return UserMdl(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uId: map['uId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserMdl.fromJson(String source) =>
      UserMdl.fromMap(json.decode(source));

  @override
  String toString() => 'UserMdl(name: $name, email: $email, uId: $uId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserMdl &&
        other.name == name &&
        other.email == email &&
        other.uId == uId;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ uId.hashCode;

  static UserMdl? fromFirebaseUser(User user) {}
}
