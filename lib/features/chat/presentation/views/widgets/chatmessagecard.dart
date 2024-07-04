import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/chat/presentation/models/messagemodel.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ChatMessageCard extends StatelessWidget {
  final Message message;
  final bool selected;
  final bool isMe;
  String roomid;

  ChatMessageCard({
    super.key,
    required this.message,
    required this.roomid,
    required this.isMe,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    if (!isMe && !message.read! && message.id != null) {
      FireData().markMessageAsRead(roomid, message.id!);
    }

    return Container(
      decoration: BoxDecoration(
        color: selected
            ? const Color.fromARGB(160, 133, 205, 201)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      margin: EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(isMe ? 12 : 0),
                bottomRight: Radius.circular(isMe ? 0 : 12),
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            color: isMe ? const Color.fromARGB(59, 112, 114, 186): const Color.fromARGB(78, 133, 205, 201),
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
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                      ),
                    if (message.msg != null) Text(message.msg!,style: Textstyle.textStyle15.copyWith(fontWeight: FontWeight.w500,color: neutralColor3),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          DateFormat('yyyy-MM-dd hh:mm:ss')
                              .format(message.createdAt ?? DateTime.now()),
                          style:  Textstyle.textStyle12.copyWith(fontWeight: FontWeight.w400,color: neutralColor3),
                        ),
                        SizedBox(width: 6),
                        if (isMe)
                          Icon(
                            Iconsax.tick_circle,
                            color: message.read == true
                                ? accentColor3
                                : Colors.grey,
                            size: 18,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
