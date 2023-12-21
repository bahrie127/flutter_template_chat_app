import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String id;
  final String userName;
  final String email;
  UserModel({
    required this.id,
    required this.userName,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': userName,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      userName: map['name'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot.id,
      userName: snapshot['name'] ?? '',
      email: snapshot['email'] ?? '',
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      userName: user.email!.replaceAll('@gmail.com', ''),
      email: user.email!,
    );
  }
}
