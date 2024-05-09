import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:graduation/core/utils/assets.dart';
import 'package:graduation/core/utils/imageprop.dart';

class ImageSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .35,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
          items: [
            //1st Image of Slider
            ImageContainerModel(
              imagePath: AssetsData.slide1,
            ),

            //2nd Image of Slider
            ImageContainerModel(
              imagePath: AssetsData.slide2,
            ),
            //3rd Image of Slider
            ImageContainerModel(
              imagePath: AssetsData.slide3,
            ),

            //4th Image of Slider
            ImageContainerModel(
              imagePath: AssetsData.slide4,
            ),
          ],

          //Slider Container properties
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            autoPlay: true,
            initialPage: 0,
            enableInfiniteScroll: true,
            viewportFraction: 1,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            pageSnapping: true,
            autoPlayInterval: Duration(seconds: 2),
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(milliseconds: 200),
          )),
    );
  }
}
