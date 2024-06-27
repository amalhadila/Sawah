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
        height: MediaQuery.of(context).size.height * .22,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(25), boxShadow: [
          BoxShadow(
              blurRadius: 40,
              color: Colors.grey.withOpacity(.1),
              spreadRadius: 0,
              offset: Offset(10, 10))
        ]),
        child: Card(
          elevation: 10,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .128,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                       img,
                        fit: BoxFit.fill,
                        width: double.infinity,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        FontAwesomeIcons.locationDot,
                        color: textcolor,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        child: Text(
                          '$location',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
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
