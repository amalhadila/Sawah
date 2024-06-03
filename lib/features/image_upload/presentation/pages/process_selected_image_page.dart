import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation/features/image_upload/presentation/pages/detected_land_mark_view.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/widgets/appbar.dart';
import '../../data/models/land_mark_detection_model.dart';

class ProcessImagePage extends StatefulWidget {
  final XFile selectedImage;
  const ProcessImagePage({super.key, required this.selectedImage});

  @override
  State<ProcessImagePage> createState() => _ProcessImagePageState();
}

class _ProcessImagePageState extends State<ProcessImagePage> {
  final Dio _dio = Dio();
  Future<void> uploadImageToServer() async {
    try {
      var formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(widget.selectedImage.path,
            filename: "photo", contentType: MediaType('image', 'jpeg')),
      });
      var response = await _dio.post(
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            "GEN_AI_API_KEY": "AIzaSyCG2YD1d94hMUCy-fYI-jTlQ7fG9gMbB0Y"
          },
        ),
        'http://192.168.1.2:8000/api/v1/detections',
        data: formData,
      );
      LandMarkDetectionModel landMarkDetectionModel =
          LandMarkDetectionModel.fromJson(response.data);
      Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => DetectedLandMarkView(
            selectedImage: widget.selectedImage,
            landMarkDetectionModel: landMarkDetectionModel),
      ));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
    // finally {
    //   log("failed to upload image to server due to $");
    // }
  }

  @override
  void initState() {
    super.initState();
    uploadImageToServer();
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
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('imageUpload.process'.tr()))
        ],
      ),
    );
  }
}
