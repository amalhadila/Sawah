import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:sawah/features/image_upload/presentation/pages/detected_land_mark_view.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/widgets/appbar.dart';
import '../../data/models/land_mark_detection_model.dart';

class ProcessImagePage extends StatefulWidget {
  final XFile selectedImage;
  final    Position? currentPosition;

  const ProcessImagePage({super.key, required this.selectedImage,this.currentPosition});

  @override
  State<ProcessImagePage> createState() => _ProcessImagePageState();
}

class _ProcessImagePageState extends State<ProcessImagePage> {
  final Dio _dio = Dio();
Future<void> uploadImageToServer() async {
    try {
      var formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          widget.selectedImage.path,
          filename: "photo",
          contentType: MediaType('image', 'jpeg'),
        ),
        'lat': '29.9792',
        //widget.currentPosition?.latitude.toString(),
        'lng': '31.1342'
        //widget.currentPosition?.longitude.toString(),
      });
      var response = await _dio.post(
        'https://sawahonline.com/api/v1/detections',
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            "GEN_AI_API_KEY": "AIzaSyCG2YD1d94hMUCy-fYI-jTlQ7fG9gMbB0Y",
          },
        ),
        data: formData,
      );
      LandMarkDetectionModel landMarkDetectionModel =
          LandMarkDetectionModel.fromJson(response.data);
      Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => DetectedLandMarkView(
            selectedImage: widget.selectedImage!,
            landMarkDetectionModel: landMarkDetectionModel),
      ));
      print(landMarkDetectionModel);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
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
