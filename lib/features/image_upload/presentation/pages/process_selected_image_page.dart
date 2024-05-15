import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/widgets/appbar.dart';

class ProcessImagePage extends StatefulWidget {
  final XFile selectedImage;
  const ProcessImagePage({super.key, required this.selectedImage});

  @override
  State<ProcessImagePage> createState() => _ProcessImagePageState();
}

class _ProcessImagePageState extends State<ProcessImagePage> {
  final Dio _dio = Dio();
  Future<void> uploadImageToServer() async {
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(widget.selectedImage.path,
          filename: "file"),
    });
    final response = await _dio.post(
      options: Options(
        headers: {'Content-Type': 'multipart/form-data'},
      ),
      'api',
      data: formData,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
              child: Image.file(File(widget.selectedImage.path),
                  width: 300, height: 200, fit: BoxFit.cover)),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text('Processing'))
        ],
      ),
    );
  }
}
