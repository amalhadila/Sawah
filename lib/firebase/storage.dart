import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:graduation/firebase/firedatabase.dart';

class FireStorage {
  final FirebaseStorage _firestorage = FirebaseStorage.instance;

  Future sendImage(File file, String roomId,String type) async {
    try {
      String ext = file.path.split('.').last;
      final ref = _firestorage.ref().child("images/$roomId.$ext");
      await ref.putFile(file);
       String imgurl=await ref.getDownloadURL();
       FireData().sendMessage( imageUrl: imgurl, roomId: roomId,type: type);

    } catch (e) {
      print('Error sending image: $e');
      rethrow;
    }
  }

  void printImageUrl(String imgurl) {
    print('Image URL: $imgurl');
  }
}
