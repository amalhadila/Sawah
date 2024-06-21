import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final FirebaseStorage firestorage = FirebaseStorage.instance;

  Future<String> sendImage(File file, String messageId) async {
    String ext = file.path.split('.').last;
    final ref = firestorage.ref().child("images/$messageId.$ext");
    await ref.putFile(file);
    return await ref.getDownloadURL();
  }

  void printImageUrl(String imageUrl) {
    print(imageUrl);
  }
}
