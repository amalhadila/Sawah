import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/constants.dart';
//import 'package:graduation/core/utils/style.dart';

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
              color: 
              shadow,
              // Color(0xFF7073BA),
              spreadRadius: 0,
              offset: Offset(0,2))
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
                      child: Image.network(
                       img,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      color: kmaincolor2,
                       ///////////////////////// color: ksecondcolor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        FontAwesomeIcons.locationDot,
                        color: accentColor1,
                        size: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        child: Text(
                          '$location',
                          style: TextStyle(
                              color: ksecondcolor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}