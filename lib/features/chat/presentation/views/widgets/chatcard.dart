import 'package:flutter/material.dart';
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
      child: ListTile(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(roomid: chatroom.id!,),
                ),
              ),
          leading: const CircleAvatar(),
          title: Text(chatroom.id.toString()),
          subtitle: Text(chatroom.lastMessage!),
          trailing: const Badge(
            padding: EdgeInsets.symmetric(horizontal: 12),
            label: Text("3"),
            largeSize: 30,
          )),
    );
  }
}