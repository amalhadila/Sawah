import 'package:flutter/material.dart';
import '../widgets/image_upload_widget.dart';

enum ImageUploadSource { gallery, camera }

class ImagesUploadPage extends StatefulWidget {
  const ImagesUploadPage({super.key});

  @override
  State<ImagesUploadPage> createState() => _ImagesUploadPageState();
}

class _ImagesUploadPageState extends State<ImagesUploadPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ImageUploadWidget(
            source: ImageUploadSource.gallery,
          ),
          ImageUploadWidget(
            source: ImageUploadSource.camera,
          ),
        ],
      ),
    ));
  }
}
