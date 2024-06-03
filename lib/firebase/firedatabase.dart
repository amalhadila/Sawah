import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/chat/presentation/models/messagemodel.dart';
import 'package:graduation/features/chat/presentation/models/romemodel.dart';
import 'package:uuid/uuid.dart';

class FireData {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> creatRoom() async {
    List<String> members = [myUid, userId]..sort((a, b) => a.compareTo(b));
    QuerySnapshot roomExist = await firestore
        .collection('rooms')
        .where('members', arrayContains: members)
        .get();

    if (roomExist.docs.isEmpty) {
      ChatRoom chatroom = ChatRoom(
        id: members.toString(),
        createdAt: DateTime.now().toString(),
        lastMessage: "",
        lastMessageTime: DateTime.now().toString(),
        members: members,
      );
      await firestore
          .collection('rooms')
          .doc(members.toString())
          .set(chatroom.toJson());
    }
  }

  Future<String> sendMessage(
      {required String toId,
      required String msg,
      String? imageUrl,
      required String roomid}) async {
    String msgid = Uuid().v1();
    final message = Message(
      toId: toId,
      fromId: myUid,
      msg: msg,
      read: false,
      createdAt: DateTime.now(),
      type: imageUrl != null ? 'image' : 'text',
      imageUrl: imageUrl,
    );

    try {
      DocumentReference docRef = await firestore
          .collection('rooms')
          .doc(roomid)
          .collection('messages')
          .add(message.toJson());
      await docRef.update({'id': docRef.id});
      return docRef.id;
    } catch (e) {
      print('Error sending message: $e');
      rethrow;
    }
  }

  Future<void> markMessageAsRead(String roomId, String messageId) async {
    try {
      await firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(messageId)
          .update({'read': true});
    } catch (e) {
      print('Error marking message as read: $e');
      rethrow;
    }
  }
}
