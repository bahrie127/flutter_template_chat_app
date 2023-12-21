import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/channel_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';

String channelid(String id1, String id2) {
  if (id1.hashCode < id2.hashCode) {
    return '$id1-$id2';
  } else {
    return '$id2-$id1';
  }
}

class FirebaseDatasource {
  FirebaseDatasource._init();

  static final FirebaseDatasource instance = FirebaseDatasource._init();

  Stream<List<UserModel>> allUser() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((snapShot) {
      List<UserModel> rs = [];

      for (var element in snapShot.docs) {
        rs.add(UserModel.fromDocumentSnapshot(element));
      }

      return rs;
    });
  }

  Stream<List<Channel>> channelStream(String userId) {
    return FirebaseFirestore.instance
        .collection('channels')
        .where('memberIds', arrayContains: userId)
        .orderBy('lastTime', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<Channel> rs = [];
      for (var element in querySnapshot.docs) {
        rs.add(Channel.fromDocumentSnapshot(element));
      }
      return rs;
    });
  }

  Future<void> updateChannel(
      String channelId, Map<String, dynamic> data) async {
    await FirebaseFirestore.instance
        .collection('channels')
        .doc(channelId)
        .set(data, SetOptions(merge: true));
  }

  Future<void> addMessage(Message message) async {
    await FirebaseFirestore.instance
        .collection('messages')
        .add(message.toMap());
  }

  Stream<List<Message>> messageStream(String channelId) {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('channelId', isEqualTo: channelId)
        .orderBy('sendAt', descending: true)
        .snapshots()
        .map((querySnapshot) {
      List<Message> rs = [];
      for (var element in querySnapshot.docs) {
        rs.add(Message.fromDocumentSnapshot(element));
      }
      return rs;
    });
  }
}
