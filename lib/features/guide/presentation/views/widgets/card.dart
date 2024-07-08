import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';

class guideCard extends StatelessWidget {
  final String imageUrl;
  final String landmarkname;
  final String date;

  const guideCard({
    Key? key,
    required this.imageUrl,
    required this.landmarkname,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = screenWidth * 0.55;

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        child: Container(
          height: cardHeight,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: secondaryColor1,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    height: cardHeight * .67,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            landmarkname,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ksecondcolor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          //  const SizedBox(height: 6),

                          Text(
                            date,
                            style: const TextStyle(
                              fontSize: 13,
                              color: neutralColor2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
