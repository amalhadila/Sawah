import 'package:flutter/material.dart';
import 'package:sawah/core/widgets/appbar.dart';
import 'package:sawah/features/landmarks/presentation/views/widgets/landmark_grid.dart';

class LandmarksBody extends StatelessWidget {
  LandmarksBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(), body: landmarkGrid());
  }
}
