import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sawah/auth/cach/cach_helper.dart';
import 'package:sawah/auth/core_login/api/end_point.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/features/chat/presentation/models/messagemodel.dart';
import 'package:sawah/features/chat/presentation/models/romemodel.dart';

class ChatCard extends StatelessWidget {
  ChatCard({
    required this.chatroom,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
    super.key,
  });

  final ChatRoom chatroom;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final isMe = chatroom.userid != CacheHelper().getData(key: apikey.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        shadowColor: shadow,
        elevation: 2.5,
        color: selected ? accentColor3.withOpacity(0.5) : kbackgroundcolor,
        child: Padding(
          padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
          child: ListTile(
            onTap: onTap,
            onLongPress: onLongPress,
            leading: CircleAvatar(
              backgroundImage: NetworkImage(chatroom.userphoto!),
              radius: 40,
            ),
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
                      .where(
                          (element) => element.read != null && !element.read!)
                      .where((element) =>
                          element.fromId !=
                          CacheHelper().getData(key: apikey.id))
                      .toList();

                  if (unreadmessglist.isNotEmpty) {
                    return Badge(
                      backgroundColor: accentColor3,
                      largeSize: 25,
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
            title: Text(
                isMe ? chatroom.name.toString() : chatroom.myname.toString(),
                style: Textstyle.textStyle18.copyWith(
                  color: neutralColor3,
                  fontWeight: FontWeight.w500,
                )),
            subtitle: Text(
              chatroom.lastMessage == ""
                  ? 'send a message'
                  : chatroom.lastMessage!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Textstyle.textStyle13.copyWith(
                  color: neutralColor3,
                  fontWeight: FontWeight.w500,
                  height: 1.4),
            ),
          ),
        ),
      ),
    );
  }
}
