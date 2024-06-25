import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class infoimg extends StatelessWidget {
  const infoimg({
    Key? key,
    this.imageslink,
    required this.imagecoverlink,
  }) : super(key: key);

  final List<dynamic>? imageslink;
  final String imagecoverlink;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Carousel or Cover Image Widget
        if (imageslink != null)
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            child: CarouselSlider(
              items: imageslink!.map((image) {
                return Image.asset(
                  'assets/img/landmarks/$image',
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
              ),
            ),
          ),
        // Back Arrow Button
        Positioned(
          top: 40.0,
          left: 10.0,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.orange),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
