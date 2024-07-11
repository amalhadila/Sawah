import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:shimmer/shimmer.dart';
//import 'package:sawah/core/utils/style.dart';

const kCardColor = Color(0xffF2F2F2);

class CustomCard extends StatelessWidget {
  CustomCard(
      {Key? key,
      required this.img,
      required this.text,
      this.onTap,
      required this.location});

  final String img;
  final String text;
  final String location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: MediaQuery.of(context).size.height * .3,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
              blurRadius: 3,
              color: shadow,
              // Color(0xFF7073BA),
              spreadRadius: 0,
              offset: Offset(0, 2))
        ]),
        child: Card(
          elevation: 10,
          color: secondaryColor1,
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .13,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: img,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            width: double.infinity,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Textstyle.textStyle13,
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      color: accentColor1,
                      size: 18,
                    ),
                    Text(
                      '$location',
                      style: Textstyle.textStyle12,
                    ),
                  ],
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
