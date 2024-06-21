import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/chat/presentation/models/romemodel.dart';
import 'package:graduation/features/chat/presentation/views/widgets/chatcard.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:iconsax/iconsax.dart';
import 'package:graduation/firebase/firedatabase.dart';


class ChatHomeScreen extends StatefulWidget {
   ChatHomeScreen({super.key});
  String? token;

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  TextEditingController emailCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // FirebaseMessaging.instance.requestPermission();
      //     //       await  FirebaseMessaging.instance.getToken().then((onValue){
      //     //           if (onValue !=null){
      //     //              widget.token=onValue;
      //     //              FireData().createUser(onValue);
      //     //           }
      //     //       });
      //           final roomId = await FireData().creatRoom(
      //            // widget.products.guide!
      //            '66630d9ee76600fd06fc7eb2'
                   
      //             );
           
      //               GoRouter.of(context)
      //             .push('/ChatScreen',extra: [roomId,
      //             //widget.products.guide!
      //             '66630d9ee76600fd06fc7eb2'
      //             ]);
      //   },
      //   child: const Icon(Iconsax.message_add),
      // ),
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: const Text("Chats",style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kmaincolor),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kmaincolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
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
  .map((e) => ChatRoom.fromJson(e.data() as Map<String, dynamic>))
  .toList()
  ..sort((a, b) => b.lastMessageTime!.compareTo(a.lastMessageTime!));

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
