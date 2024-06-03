import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/chat/presentation/models/messagemodel.dart';
import 'package:graduation/features/chat/presentation/views/widgets/chatmessagecard.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:graduation/firebase/storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatefulWidget {
   ChatScreen({super.key,required this.roomid});
    String roomid;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  void _sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isNotEmpty || _imageFile != null) {
      String? imageUrl;

      if (_imageFile != null) {
        File imageFile = File(_imageFile!.path);
        try {
          String messageId = await FireData().sendMessage(roomid: widget.roomid, toId: userId, msg: message);
          print('Message ID: $messageId');

          imageUrl = await FireStorage().sendImage(imageFile, messageId);
          print('Image URL: $imageUrl');

          await FirebaseFirestore.instance.collection('rooms').doc(widget.roomid).collection('messages').doc(messageId).update({
            'msg': message,
            'imageUrl': imageUrl,
          });
        } catch (e) {
          print('Error uploading image: $e');
        }
        setState(() {
          _imageFile = null; // Clear the selected image after upload
        });
      } else {
        await FireData().sendMessage(roomid: widget.roomid, toId: userId, msg: message);
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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.trash),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.copy),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('rooms').doc(widget.roomid)
                    .collection('messages')
                    .orderBy('created_at', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('No messages'));
                  }

                  final messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final messageData =
                          messages[index].data() as Map<String, dynamic>;
                      final message = Message.fromJson(messageData);
                      final isMe = message.fromId == myUid;

                      return ChatMessageCard(
                        roomid:widget.roomid,
                        message: message,
                        isMe: isMe,
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
                              onPressed: () {},
                              icon: const Icon(Iconsax.emoji_happy),
                            ),
                            IconButton(
                              onPressed: _pickImage, // Call the pick image function
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