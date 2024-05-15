import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/widgets/appbar.dart';
import '../../data/models/land_mark_detection_model.dart';

class DetectedLandMarkView extends StatefulWidget {
  XFile selectedImage;
  LandMarkDetectionModel landMarkDetectionModel;
  DetectedLandMarkView(
      {super.key,
      required this.selectedImage,
      required this.landMarkDetectionModel});

  @override
  State<DetectedLandMarkView> createState() => _DetectedLandMarkViewState();
}

class _DetectedLandMarkViewState extends State<DetectedLandMarkView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.file(
                File(widget.selectedImage.path),
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.landMarkDetectionModel.data.gemini.label,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:
                    Text(widget.landMarkDetectionModel.data.gemini.description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
