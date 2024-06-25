import 'package:flutter/material.dart';
import 'package:graduation/core/widgets/appbar.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/infoimg.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/information.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/name_location.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';

class InfViewBody extends StatelessWidget {
  const InfViewBody(
      {super.key, this.landmarkoncatModel, this.mostVisitedModel});
  final LandmarkOnCatModel? landmarkoncatModel;
  final MostVisitedModel? mostVisitedModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                infoimg(
                  imageslink:
                      (landmarkoncatModel?.images ?? mostVisitedModel?.images)!,
                  imagecoverlink: (landmarkoncatModel?.imageCover ??
                      mostVisitedModel?.imageCover)!,
                ),
                LocationWidget(
                  name: (landmarkoncatModel?.name ?? mostVisitedModel?.name)!,
                  location: (landmarkoncatModel?.location?.governorate ??
                      mostVisitedModel?.location?.governorate)!,
                ),
                Information(
                    text: (landmarkoncatModel?.description ??
                        mostVisitedModel?.description)!,landmarkmodel: landmarkoncatModel!,),
              ],
            ),
          ),
        ));
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
