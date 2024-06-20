import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:graduation/constants.dart';
import 'package:graduation/features/chat/presentation/models/messagemodel.dart';
import 'package:graduation/features/chat/presentation/views/widgets/chatmessagecard.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:graduation/firebase/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.roomid, required this.userId});
  String roomid;
  String userId;
  List<String> selectedmsg = [];

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

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
          imageUrl = await FireStorage().sendImage(imageFile, widget.roomid, widget.userId, 'Image');
          print('Image URL: $imageUrl');
        } catch (e) {
          print('Error uploading image: $e');
        }
        setState(() {
          _imageFile = null; // Clear the selected image after upload
        });
      }

      await FireData().sendMessage(roomId: widget.roomid, toId: widget.userId, msg: message, imageUrl: imageUrl);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("user1"),
            Text(
              "Last Seen 11:28 am",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          widget.selectedmsg.isNotEmpty
              ? IconButton(
                  onPressed: () async {
                    await FireData().deleteMessages(widget.roomid, widget.selectedmsg);
                    widget.selectedmsg.clear();
                  },
                  icon: const Icon(Iconsax.trash),
                )
              : Container(),
        ],
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
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      final isMe = message.fromId == myUid;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (widget.selectedmsg.isNotEmpty) {
                              widget.selectedmsg.contains(message.id)
                                  ? widget.selectedmsg.remove(message.id)
                                  : widget.selectedmsg.add(message.id!);
                            }
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            widget.selectedmsg.contains(message.id)
                                ? widget.selectedmsg.remove(message.id)
                                : widget.selectedmsg.add(message.id!);
                          });
                        },
                        child: ChatMessageCard(
                          selected: widget.selectedmsg.contains(message.id),
                          roomid: widget.roomid,
                          message: message,
                          isMe: isMe,
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
                              icon: const Icon(Iconsax.camera),
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
                  icon: const Icon(Iconsax.send_1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
