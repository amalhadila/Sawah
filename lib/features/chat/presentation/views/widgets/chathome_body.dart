import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/chat/presentation/models/romemodel.dart';
import 'package:graduation/features/chat/presentation/views/widgets/chatcard.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:iconsax/iconsax.dart';

class ChatHomeScreen extends StatefulWidget {
  ChatHomeScreen({super.key});
  String? token;

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  TextEditingController emailCon = TextEditingController();
  final ValueNotifier<List<String>> _selectedRoomsNotifier = ValueNotifier<List<String>>([]);

  void _toggleSelection(String roomId) {
    List<String> selectedRooms = List.from(_selectedRoomsNotifier.value);
    if (selectedRooms.contains(roomId)) {
      selectedRooms.remove(roomId);
    } else {
      selectedRooms.add(roomId);
    }
    _selectedRoomsNotifier.value = selectedRooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: const Text("Chats", style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: kmaincolor)),
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
        actions: [
          ValueListenableBuilder<List<String>>(
            valueListenable: _selectedRoomsNotifier,
            builder: (context, selectedRooms, child) {
              return selectedRooms.isNotEmpty
                  ? IconButton(
                      onPressed: () async {
                        await FireData().deleteRooms(selectedRooms);
                        _selectedRoomsNotifier.value = [];
                      },
                      icon: const Icon(Iconsax.trash),
                    )
                  : Container();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                        final chatroom = chatrooms[index];
                        final isMe = chatroom.userid != myUid;
                        return GestureDetector(
                          onTap: () {
                            if (_selectedRoomsNotifier.value.isNotEmpty) {
                              _toggleSelection(chatroom.id!);
                            } else {
                              GoRouter.of(context).push('/ChatScreen', extra: [chatroom.id!,chatroom.name]);
                            }
                          },
                          onLongPress: () {
                            _toggleSelection(chatroom.id!);
                          },
                          child: ValueListenableBuilder<List<String>>(
                            valueListenable: _selectedRoomsNotifier,
                            builder: (context, selectedRooms, child) {
                              return ChatCard(
                                chatroom: chatroom,
                                selected: selectedRooms.contains(chatroom.id),
                                onTap: () {
                                  if (_selectedRoomsNotifier.value.isNotEmpty) {
                                    _toggleSelection(chatroom.id!);
                                  } else {
                                    GoRouter.of(context).push('/ChatScreen', extra: [chatroom.id!,isMe? chatroom.name!:chatroom.myname!]);
                                  }
                                },
                                onLongPress: () {
                                  _toggleSelection(chatroom.id!);
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
