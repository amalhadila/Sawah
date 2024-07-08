import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/core/widgets/appbar.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/infoimg.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/information.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';

class Landmarkdetails extends StatelessWidget {
  Landmarkdetails({super.key, this.description, this.images, this.name});
  List<String>? images;
  String? description;
  String? name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infoimg(
                  imageslink: images,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        name!,
                        style: Textstyle.textStyle20.copyWith(color: neutralColor3),
                                          softWrap: true,

                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(description!,style:  Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w500,
                                height: 1.7),),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
  }
}
