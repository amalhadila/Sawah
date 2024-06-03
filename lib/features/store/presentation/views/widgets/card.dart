import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/constants.dart';

class productCard extends StatefulWidget {
  final String imglink;
  final String? rating;
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
                padding: const EdgeInsets.only(right: 10, left: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            // widget.imglink,
                            'assets/img/landmarks/pyramids2.jpg',
                            height: MediaQuery.sizeOf(context).height * .16,
                            width: MediaQuery.sizeOf(context).width * .39,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
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
                    SizedBox(width: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 44, 42, 42),
                              fontSize: 10,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          widget.info ?? '',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 56, 54, 54),
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              r'$' '${widget.price.toString()}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 44, 42, 42),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 40),
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
                                    fontSize: 14,
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
