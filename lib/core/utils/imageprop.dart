import 'package:flutter/material.dart';

class ImageContainerModel extends StatelessWidget {
  final String imagePath;

  ImageContainerModel({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
