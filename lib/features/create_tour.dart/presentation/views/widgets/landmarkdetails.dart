import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/widgets/appbar.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/infoimg.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/information.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';

class Landmarkdetails extends StatelessWidget {
   Landmarkdetails(
      {super.key,this.description,this.images ,this.name});
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
                  imageslink:
                      images,
                  
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text(  name!,style: TextStyle(color: kmaincolor,fontSize: 18,fontWeight: FontWeight.w700),),
                   SizedBox(height: 3,),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(  description!),
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