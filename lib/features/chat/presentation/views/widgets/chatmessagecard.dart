import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation/features/chat/presentation/models/messagemodel.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ChatMessageCard extends StatelessWidget {
  final Message message;
  final bool isMe;
  String roomid;

  ChatMessageCard({
    super.key,
    required this.message,
    required this.roomid,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    if (!isMe && !message.read!) {
      FireData().markMessageAsRead(roomid, message.id!);
    }

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (isMe)
          IconButton(onPressed: () {}, icon: Icon(Iconsax.message_edit)),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(isMe ? 16 : 0),
              bottomRight: Radius.circular(isMe ? 0 : 16),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          color: isMe
              ? Theme.of(context).colorScheme.background
              : Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (message.imageUrl != null)
                    CachedNetworkImage(
                      imageUrl: message.imageUrl!,
                      placeholder: (context, url) {
                        return const CircularProgressIndicator();
                      },
                    ),
                  if (message.msg != null) Text(message.msg!),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (isMe)
                        Icon(
                          Iconsax.tick_circle,
                          color: message.read == true
                              ? Colors.blueAccent
                              : Colors.grey,
                          size: 18,
                        ),
                      Text(
                        DateFormat('yyyy-MM-dd hh:mm:ss')
                            .format(message.createdAt ?? DateTime.now()),
                      ),
                      SizedBox(width: 6),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
