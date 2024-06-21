import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/chat/presentation/models/messagemodel.dart';
import 'package:graduation/features/chat/presentation/models/romemodel.dart';
import 'package:graduation/features/chat/presentation/views/widgets/chat_body.dart';

class ChatCard extends StatelessWidget {
  ChatCard({
    required this.chatroom,
    super.key,
  });
  ChatRoom chatroom;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: kbackgroundcolor,
      elevation: 0,
      child: ListTile(

          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    roomid: chatroom.id!,
                    userId: chatroom.userid!,
                    name:chatroom.name!,
                  ),
                ),
              ),
          leading: const CircleAvatar(),
trailing: StreamBuilder(
  stream: FirebaseFirestore.instance
      .collection('rooms')
      .doc(chatroom.id)
      .collection('messages')
      .snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasData && snapshot.data != null) {
      final unreadmessglist = snapshot.data!.docs
          .map((e) => Message.fromJson(e.data()))
          .where((element) => element.read != null && !element.read!)
          .where((element) => element.fromId != myUid)
          .toList();

      if (unreadmessglist.isNotEmpty) {
        return Badge(
          largeSize: 20,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          label: Text(unreadmessglist.length.toString()),
        );
      } else {
        return const Text('');
      }
    } else {
      return const SizedBox(); 
    }
  },
),
          title: Text(chatroom.name.toString(),
    style: TextStyle(
               color: ksecondcolor,fontWeight: FontWeight.bold)),
          subtitle:Text(chatroom.lastMessage == ""
      ? 'send message'
    : chatroom.lastMessage!
    ,maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
               color: ksecondcolor)),
         ),
    );
  }
}
