import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:shimmer/shimmer.dart';

const kCardColor = Color(0xffF2F2F2);

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key, required this.imglink, required this.text, this.onTap});

  final String imglink;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 3),
                color: shadow,

                //Color(0xFF7073BA),
                spreadRadius: 0,
                blurStyle: BlurStyle.normal)
          ],
        ),
        child: Card(
          color: secondaryColor1,
          elevation: 0,
          child: Padding(
            padding:
                const EdgeInsets.only(top: 6, left: 8, right: 8, bottom: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: 
                     CachedNetworkImage(
      imageUrl: imglink,
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
    ),
                  
                  ),
                ),
                const Spacer(),
                Text(
                  text,
                  style: Textstyle.textStyle12.copyWith(color: kmaincolor2),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
