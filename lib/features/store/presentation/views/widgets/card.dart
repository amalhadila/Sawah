import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/constants.dart';

class productCard extends StatefulWidget {
  final String imglink;
  final int? rating;
  final String text;
  final String? info;
  final dynamic price;
  final VoidCallback ontap;

  productCard({
    Key? key,
    required this.imglink,
    this.rating,
    required this.text,
    this.info,
    required this.ontap,
    required this.price,
  }) : super(key: key);

  @override
  _productCardState createState() => _productCardState();
}

class _productCardState extends State<productCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define your responsive font sizes here
    double titleFontSize = screenWidth * 0.039;
    double infoFontSize = screenWidth * 0.034;
    double priceFontSize = screenWidth * 0.04;
    double ratingFontSize = screenWidth * 0.035;

    return GestureDetector(
      onTap: widget.ontap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            child: Card(
              color: kbackgroundcolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 0, left: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/img/landmarks/pyramids2.jpg',
                            height: screenHeight * .16,
                            width: screenWidth * .39,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                            child: Icon(
                              isFavorite
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              color: isFavorite ? kmaincolor : Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth *
                              0.43, // Adjust width for text wrapping
                          child: Text(
                            widget.text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color.fromARGB(255, 44, 42, 42),
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Container(
                          width: screenWidth *
                              0.42, // Adjust width for text wrapping
                          child: Text(
                            widget.info!,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Color.fromARGB(255, 56, 54, 54),
                              fontSize: infoFontSize,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              r'$' '${widget.price.toString()}',
                              style: TextStyle(
                                fontSize: priceFontSize,
                                color: Color.fromARGB(255, 44, 42, 42),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 80),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.solidStar,
                                  size: 16,
                                  color: kmaincolor,
                                ),
                                const SizedBox(
                                  width: 6.3,
                                ),
                                Text(
                                  widget.rating.toString(),
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 56, 54, 54),
                                    fontSize: ratingFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
