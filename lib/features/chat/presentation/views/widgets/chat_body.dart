import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:sawah/constants.dart';
import 'package:sawah/features/chat/presentation/models/messagemodel.dart';
import 'package:sawah/features/chat/presentation/views/widgets/chatmessagecard.dart';
import 'package:sawah/firebase/firedatabase.dart';
import 'package:sawah/firebase/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.roomid, required this.name,required this.photo});
  String roomid;
  String name;
  String photo;

  List<String> selectedmsg = [];

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<List<String>> _selectedMessagesNotifier =
      ValueNotifier<List<String>>([]);

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isNotEmpty || _imageFile != null) {
      String? imageUrl;

      if (_imageFile != null) {
        File imageFile = File(_imageFile!.path);
        try {
          imageUrl =
              await FireStorage().sendImage(imageFile, widget.roomid, 'Image');
          print('Image URL: $imageUrl');
        } catch (e) {
          print('Error uploading image: $e');
        }
        setState(() {
          _imageFile = null; // Clear the selected image after upload
        });
      } else {
        await FireData().sendMessage(roomId: widget.roomid, msg: message);
      }

      _messageController.clear();
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  void _toggleSelection(String messageId) {
    List<String> selectedMessages = List.from(_selectedMessagesNotifier.value);
    if (selectedMessages.contains(messageId)) {
      selectedMessages.remove(messageId);
    } else {
      selectedMessages.add(messageId);
    }
    _selectedMessagesNotifier.value = selectedMessages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
  preferredSize: Size.fromHeight(65),
  child: Material(
    color: kbackgroundcolor,
    elevation: 2.5,
    shadowColor: shadow,
    child:AppBar(
  elevation: 0,
  foregroundColor: kbackgroundcolor,
  shadowColor: shadow,
  backgroundColor: kbackgroundcolor,
  title: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Expanded(
        child: Text(
          widget.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kmaincolor,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  ),
  leading: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: kmaincolor,
          size: 22,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      CircleAvatar(
        backgroundImage: NetworkImage(widget.photo),
        radius: 22, // Adjust the radius to fit better
      ),
    ],
  ),
  leadingWidth: 100, // Adjust the width to ensure enough space for the leading widget

        actions: [
          ValueListenableBuilder<List<String>>(
            valueListenable: _selectedMessagesNotifier,
            builder: (context, selectedMessages, child) {
              return selectedMessages.isNotEmpty
                  ? IconButton(
                      onPressed: () async {
                        await FireData()
                            .deleteMessages(widget.roomid, selectedMessages);
                        _selectedMessagesNotifier.value = [];
                      },
                      icon: const Icon(Iconsax.trash,color: kmaincolor,),
                    )
                  : Container();
            },
          ),
        ],
      ),
  ),
),
 
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('rooms')
                    .doc(widget.roomid)
                    .collection('messages')
                    .orderBy('created_at', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No messages'));
                  }

                  final messages = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return Message.fromJson(data);
                  }).toList();

                  return ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.fromId == myUid;

                      return GestureDetector(
                        onTap: () {
                          if (_selectedMessagesNotifier.value.isNotEmpty) {
                            _toggleSelection(message.id!);
                          }
                        },
                        onLongPress: () {
                          _toggleSelection(message.id!);
                        },
                        child: ValueListenableBuilder<List<String>>(
                          valueListenable: _selectedMessagesNotifier,
                          builder: (context, selectedMessages, child) {
                            return ChatMessageCard(
                              selected: selectedMessages.contains(message.id),
                              roomid: widget.roomid,
                              message: message,
                              isMe: isMe,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            if (_imageFile != null)
              Image.file(
                File(_imageFile!.path),
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: TextField(
                      controller: _messageController,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputDecoration(
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: _pickImage,
                              icon: const Icon(Iconsax.camera5,size: 30,color: kmaincolor,)
                            ),
                          ],
                        ),
                        border: InputBorder.none,
                        hintText: "Message",
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: const Icon(Icons.send_rounded,color: kmaincolor,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
