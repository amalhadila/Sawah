import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class infoimg extends StatelessWidget {
  const infoimg({
    super.key,
    this.imageslink,
    required this.imagecoverlink,
  });

  final List<dynamic>? imageslink;
  final String imagecoverlink;

  @override
  Widget build(BuildContext context) {
    if (imageslink != null) {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .31,
        child: CarouselSlider(
            items: imageslink!.map((image) {
              return Image.network(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              autoPlay: true,
              initialPage: 0,
              enableInfiniteScroll: true,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enlargeFactor: 0.3,
              pageSnapping: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            )),
      );
    } else {
      return Container(
        width: double.infinity,
        child: SizedBox(
            height: MediaQuery.of(context).size.height * .31,
            child: Image.asset(
              'assets/img/landmarks/$imagecoverlink',
              fit: BoxFit.fill,
            )),
      );
    }
  }
}
