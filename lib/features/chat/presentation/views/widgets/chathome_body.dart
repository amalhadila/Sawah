import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/chat/presentation/models/romemodel.dart';
import 'package:graduation/features/chat/presentation/views/widgets/chatcard.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:iconsax/iconsax.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  TextEditingController emailCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FireData().creatRoom();
          //   showBottomSheet(
          //     context: context,
          //     builder: (context) {
          //       return Container(
          //         padding: EdgeInsets.all(20),
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   "Enter Friend Email",
          //                   style: Theme.of(context).textTheme.bodyLarge,
          //                 ),
          //                 Spacer(),
          //                 IconButton.filled(
          //                   onPressed: () {},
          //                   icon: Icon(Iconsax.scan_barcode),
          //                 )
          //               ],
          //             ),
          //             CustomField(
          //               controller: emailCon,
          //               icon: Iconsax.direct,
          //               lable: "Email",
          //             ),
          //             SizedBox(
          //               height: 16,
          //             ),
          //             ElevatedButton(
          //                 style: ElevatedButton.styleFrom(
          //                     padding: EdgeInsets.all(16),
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(12)),
          //                     backgroundColor:
          //                         Theme.of(context).colorScheme.primaryContainer),
          //                 onPressed: () {},
          //                 child: Center(
          //                   child: Text("Create Chat"),
          //                 ))
          //           ],
          //         ),
          //       );
          //     },
          //   );
        },
        child: const Icon(Iconsax.message_add),
      ),
      appBar: AppBar(
        title: const Text("Chats"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('rooms')
                      .where('members', arrayContains: myUid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ChatRoom> chatrooms = snapshot.data!.docs
                          .map((e) => ChatRoom.fromJson(e.data()))
                          .toList()
                        ..sort((a, b) =>
                            a.lastMessageTime!.compareTo(b.lastMessageTime!));
                      return ListView.builder(
                          itemCount: chatrooms.length,
                          itemBuilder: (context, index) {
                            return ChatCard(
                              chatroom: chatrooms[index],
                            );
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
