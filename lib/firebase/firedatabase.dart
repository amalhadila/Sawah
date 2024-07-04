import 'dart:convert';
import 'package:graduation/auth/cach/cach_helper.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';
import 'package:graduation/features/chat/presentation/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/chat/presentation/models/messagemodel.dart';
import 'package:graduation/features/chat/presentation/models/romemodel.dart';

class FireData {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> creatRoom(String userId, String usrname) async {
    // createUser( token);
    List<String> members = [myUid, userId]..sort((a, b) => a.compareTo(b));
    QuerySnapshot roomExist = await firestore
        .collection('rooms')
        .where('members', arrayContains: members)
        .get();
    String roomId = members.toString();
    if (roomExist.docs.isEmpty) {
      ChatRoom chatroom = ChatRoom(
        userid: userId,
        name: usrname,
        myname: myname,
        id: roomId,
        createdAt: DateTime.now(),
        lastMessage: "",
        lastMessageTime: DateTime.now(),
        members: members,
      );
      await firestore
          .collection('rooms')
          .doc(members.toString())
          .set(chatroom.toJson());
    }
    return roomId;
  }

  Future<String> createUser(String? token) async {
    QuerySnapshot userExist = await firestore
        .collection('User')
        .where('id', isEqualTo: myUid)
        .where('pushtoken', isEqualTo: token)
        .get();

    User user = User(
      id: myUid,
      pushtoken: token,
    );

    if (userExist.docs.isEmpty) {
      await firestore
          .collection('User')
          .doc(myUid.toString())
          .set(user.toJson());
    } else {
      await firestore
          .collection('User')
          .doc(myUid.toString())
          .update(user.toJson());
    }
    return token ?? '';
  }

  Future<String?> getPushToken(String userId) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('User').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        print(doc.data()!['pushtoken']);
        return doc.data()!['pushtoken'];
      } else {
        print('Document does not exist or data is null');
        return null;
      }
    } catch (e) {
      print('Error getting push token: $e');
      return null;
    }
  }

  Future<String> getAccessToken() async {
    final serviceAccountJson = {
      ////////////////////////////////////////
      ///
      ////////////////////////////////////////
      "type": "service_account",
      "project_id": "sawahchat",
      "private_key_id": "28abfaf1e1013b788b15c8d6d1d4868e33b9c57e",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCevoZ1eerUWlMx\nVYnDdV+dnL84TqUQq4i++1PYdx6HK2QJlN+j4OW8Fnmz35oZiU5Ppk80l9qgD+k8\nxu6K/kqgJ2rlJH2Tpx2RoRGrNUpBIYFKPaDSascWTxdtS9xCKbudkIqV2fbqjhHj\nXv8ur5YP7IEsZBOYsgJhSbcBDN0oseg2YJfX8Dzch5KnuJhGLYS7zdRdpyLRT6/D\nt9h1RP0XEJ+CeWn0Z8rjhuc8SYc+KBP1tiJs4MV9lkKPVxSMfxvoNJsoKkdHz68W\ndKuAok9+3wleFvvntKo+op59s2nJykL08kwbKRpTvtu9RwhIoPT+e+9H6VZpfdMp\nAm/C6Hj9AgMBAAECggEAAk/0tf5F0vaYaIsbQCpxEjRmZzbAPPd4grwIelu7TDMe\nm0nZxwX4RC02i1lk7YYd3C6coUtmy2hy1ZPltAEntyCY9BxB36kvbhQVMSspGRn1\nv+Ve0+NISpPmW7uq4ZiSNbFD8hJP6RY1+K1FHcWdLeJiJMPYyfTkZORluKuPBvjL\nSgZSDprQDQNGCw535OhBn7bV6EV9cEsQV4m0D+hBa7YISPFpjf0yQLKAV4JLPbGr\n3OBRTqlpBr5+dc5u+mVpAOJv3QLUGiHC29hIrnhbWCIEJiNMnlfrdpRhnCYKIUHH\nXWtFkM/YBEJ5sH2tkLRY5SzPaVKN2HiVMPVbos2QgQKBgQDZtsjrKV6blY55LVkL\nJlDgwmM20nczKhDN81hjxAhJZH4Ev92nmDtc88hOkYdY2uAvL+o4jy9pV6k10XPI\n72mr0m0pbnosI5WfLso3fo5wGYTlOSmbYcuBb65h2Wqa+YXIR1xBhha83tRXilpE\nvb9wXtil/ZWeJ5+NlU+OoaycXQKBgQC6qP6ag/cvq72NSRa4nNwI7yCbGfz9SlNo\nwktULZrWX3df6rHoZ6yF56TE1p2n6yRe9TBgnq054RAmIwn4CmQS2vUNF5RbcEar\nG4FbHD//vKcgX3yFQo32SKtkNmHLXqnGvDBWeZWwohqhDEJkEhu4PUai8Zka4vHj\nvyP1cVyFIQKBgQC7deW+htqNgNMyh9d6AD33qakgFUzJ41ig3P2ouayg9USE9mf2\n3N+Qg+BftnMiESSjvNAibzfVrsNmMblOtMb6Sa/w0s2jn+g/Lly0N+aRo4eIkBXB\nUw2VoAI5AqoGUv/cmYVYbgq6CewwjFJ5iiCCs0g8dQMVMOzzTjM4jwE/iQKBgQCZ\nnOYa5yuP8bhHA7VNLNnwCEs/GX4YPQizl+JCXl2kumAVcaID7v4OHPp+e1i3jk4a\nT5IGkc9haJTPrdpQZMzCr6snoRYYwieGPVaRUohgwDKR88MYMBOAcYGLMS3+HeN+\nh/UH1XuZJ27exqYEkNp7HwJ4qncjp00F7pF7NlW7wQKBgEJBjtyQgpBe0/zBY44G\nmEHQRyAcCnYM3dClaPmC1J5iDQO8gvpctjqnuhUcV/XF/7usETazhdqLZ0YWn9pI\nWDGJ/R9Rqr+33uotaU8rvK4S2ZlG+XIIkl7vAPYTxPVSqd3XFqIDcSTkyF0dKlBh\nsKPya7JcJIeoTRPLsdfpNGPq\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-mmrf1@sawahchat.iam.gserviceaccount.com",
      "client_id": "116711881967709691100",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-mmrf1%40sawahchat.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];

    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
    );

    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
      scopes,
      client,
    );

    client.close();

    return credentials.accessToken.data;
  }

  Future<void> sendFCMMessage(
      {required String userId,
      String? msg,
      String? imageUrl,
      required String roomId}) async {
    final String serverKey = await getAccessToken();
    final String fcmEndpoint =
        'https://fcm.googleapis.com/v1/projects/sawahchat/messages:send';
    final currentFCMToken = await FirebaseMessaging.instance.getToken();

    final String? token = await getPushToken(userId);
    print(userId);
    print(token);

    if (token == null) {
      print('Push token is null for user: $userId');
      return;
    }

    final Map<String, dynamic> message = {
      'message': {
        'token': token,
        'notification': {'body': msg ?? 'New Message', 'title': 'New Message'},
        'data': {
          'current_user_fcm_token': currentFCMToken,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
          'sound': 'default',
          'status': 'done',
          'screen': 'Chat'
        }
      }
    };

    final http.Response response = await http.post(
      Uri.parse(fcmEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );

    if (response.statusCode == 200) {
      print('FCM message sent successfully');
      print('Token: $token');
      print('Message: $msg');
    } else {
      print('Failed to send FCM message: ${response.statusCode}');
    }
  }

  Future<void> deleteRooms(List<String> roomIds) async {
    try {
      final batch = FirebaseFirestore.instance.batch();

      for (final roomId in roomIds) {
        final roomRef =
            FirebaseFirestore.instance.collection('rooms').doc(roomId);
        final messagesRef = await roomRef.collection('messages').get();

        for (final doc in messagesRef.docs) {
          batch.delete(doc.reference);
        }

        batch.delete(roomRef);
      }

      await batch.commit();
    } catch (e) {
      print('Error deleting rooms: $e');
      throw e;
    }
  }

  Future<String> sendMessage(
      {
      //required String toId,
      String? msg,
      String? type,
      String? imageUrl,
      required String roomId}) async {
    DocumentSnapshot roomSnapshot =
        await FirebaseFirestore.instance.collection('rooms').doc(roomId).get();

    if (!roomSnapshot.exists) {
      throw Exception('Room does not exist');
    }

    Map<String, dynamic> roomData = roomSnapshot.data() as Map<String, dynamic>;
    List<String> members = List<String>.from(roomData['members']);

    // Determine the correct toId
    String toId = members.firstWhere((member) => member != myUid);

    final message = Message(
      toId: toId,
      fromId: myUid,
      msg: msg,
      read: false,
      createdAt: FieldValue.serverTimestamp(),
      type: type ?? 'text',
      imageUrl: imageUrl,
    );
    print(message.type);
    try {
      DocumentReference docRef = await firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .add(message.toJson());
      await firestore.collection('rooms').doc(roomId).update({
        'last_message': message.type == "text" ? msg : message.type,
        'last_message_time': DateTime.now().millisecondsSinceEpoch.toString(),
      });
      await docRef.update({'id': docRef.id});
      sendFCMMessage(
          userId: toId, msg: msg, imageUrl: imageUrl, roomId: roomId);

      return docRef.id;
    } catch (e) {
      print('Error sending message: $e');
      rethrow;
    }
  }

  Future<void> deleteMessages(String roomId, List<String> messageIds) async {
    WriteBatch batch = firestore.batch();

    try {
      for (String messageId in messageIds) {
        DocumentReference messageRef = firestore
            .collection('rooms')
            .doc(roomId)
            .collection('messages')
            .doc(messageId);
        batch.delete(messageRef);
      }

      await batch.commit();
    } catch (e) {
      print('Error deleting messages: $e');
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
