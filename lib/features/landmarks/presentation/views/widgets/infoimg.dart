import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class infoimg extends StatelessWidget {
  const infoimg({
    super.key,
    this.imageslink,
  });

  final List<dynamic>? imageslink;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .38,
      child: CarouselSlider(
          items: imageslink!.map((image) {
            return 
            CachedNetworkImage(
      imageUrl: image ,
      width: double.infinity,
      fit: BoxFit.fill,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          color: Colors.white,
        ),
      ),errorWidget: (context, url, error) => Icon(Icons.error),
    );
       
          }).toList(),
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            autoPlay: true,
            initialPage: 0,
            enableInfiniteScroll: true,
            viewportFraction: 1.05,
            enlargeCenterPage: true,
            enlargeFactor: .2,
            enlargeStrategy: CenterPageEnlargeStrategy
                .scale, // استخدم هذه الخاصية لعمل تأثير الزووم
            pageSnapping: true,

            autoPlayInterval: Duration(seconds: 5),
            autoPlayCurve: Curves.easeInOutCubicEmphasized,
            autoPlayAnimationDuration: const Duration(milliseconds: 5000),
          )),
    );
  }
}
