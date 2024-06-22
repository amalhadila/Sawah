import 'dart:convert';
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
Future<String> creatRoom(String userId,String name) async {
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
        name:name,
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

  Future<String> createUser( String? token) async {
    QuerySnapshot userExist = await firestore
        .collection('User')
        .where('id', isEqualTo: myUid).where('pushtoken', isEqualTo: token)
        .get();

    User user = User(
      id: myUid,
      pushtoken: token,
    );

    if (userExist.docs.isEmpty) {
      await firestore.collection('User').doc(myUid.toString()).set(user.toJson());
    } else {
      await firestore.collection('User').doc(myUid.toString()).update(user.toJson());
    }
    return token ?? '';
  }


  Future<String?> getPushToken(String userId) async {
  try {
    final doc = await FirebaseFirestore.instance.collection('User').doc(userId).get();
    if (doc.exists && doc.data() != null) {
      print(doc.data()!['pushtoken']);
      return doc.data()!['pushtoken'] ;
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


Future<void> sendFCMMessage({required String userId, String? msg, String? imageUrl, required String roomId}) async {
  final String serverKey = await getAccessToken();
  final String fcmEndpoint = 'https://fcm.googleapis.com/v1/projects/sawahchat/messages:send';
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
      'notification': {
        'body': msg ?? 'New Message',
        'title': 'New Message'
      },
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


Future<String> sendMessage(
    {
      //required String toId,
     String? msg,
   String? type,
    String? imageUrl,
    required String roomId}) async {
    
     DocumentSnapshot roomSnapshot = await FirebaseFirestore.instance.collection('rooms').doc(roomId).get();

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
    type: type??'text',
    imageUrl: imageUrl,
  );
  print(message.type);
  try {
    DocumentReference docRef = await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .add(message.toJson());
    await firestore
        .collection('rooms')
        .doc(roomId)
        .update({
          'last_message':message.type=="text"?  msg : message.type,
          'last_message_time': DateTime.now().millisecondsSinceEpoch.toString(),
        });
    await docRef.update({'id': docRef.id});
     sendFCMMessage(userId: toId, msg: msg, imageUrl: imageUrl, roomId: roomId);

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


