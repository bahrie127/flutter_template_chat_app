import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_model.dart';

class Channel {
  final String id;
  final List<String> memberIds;
  final String lastMessage;
  final Timestamp lastTime;
  final Map<String, bool> unRead;
  final List<UserModel> members;
  final String sendBy;
  Channel({
    required this.id,
    required this.memberIds,
    required this.lastMessage,
    required this.lastTime,
    required this.unRead,
    required this.members,
    required this.sendBy,
  });

  Map<String, dynamic> toMap() {
    return {
      'memberIds': memberIds,
      'members': members.map((user) => user.toMap()..['id'] = user.id).toList(),
      'lastMessage': lastMessage,
      'sendBy': sendBy,
      'lastTime': lastTime,
      'unRead': unRead,
    };
  }

  factory Channel.fromMap(Map<String, dynamic> map) {
    return Channel(
      id: map['id'] ?? '',
      memberIds: List<String>.from(map['memberIds']),
      members: List<UserModel>.from(
          map['members']?.map((user) => UserModel.fromMap(user))),
      lastMessage: map['lastMessage'] ?? '',
      sendBy: map['sendBy'],
      lastTime: map['lastTime'] as Timestamp,
      unRead: map['unRead'],
    );
  }
  factory Channel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Channel(
      id: snapshot.id,
      memberIds: List<String>.from(snapshot['memberIds']),
      members: List<UserModel>.from(
          snapshot['members']?.map((user) => UserModel.fromMap(user))),
      lastMessage: snapshot['lastMessage'] ?? '',
      sendBy: snapshot['sendBy'],
      lastTime: snapshot['lastTime'] as Timestamp,
      unRead: Map<String, bool>.from(snapshot['unRead']),
    );
  }
}
