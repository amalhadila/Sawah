import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';

import 'package:flutter/material.dart';

class GuideCard extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String landmarkname;
  final String date;
  final String lang;
  final String gov;
  final String? groubsize; // Make groubsize optional
  final int? price;
  const GuideCard({
    Key? key,
    required this.imageUrl,
    required this.username,
    required this.landmarkname,
    required this.date,
    required this.lang,
    required this.gov,
    this.groubsize,
    this.price, // Optional parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = screenWidth * 0.55;

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Card(
        color: Colors.black,
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
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        'assets/default_avatar.png'), // Replace with actual image if available
                  ),
                  SizedBox(width: 10),
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      buildInfoRow(Icons.location_on, gov),
                      SizedBox(height: 10),
                      buildInfoRow(Icons.calendar_today, date),
                      SizedBox(height: 10),
                      buildInfoRow(Icons.language, lang),
                      SizedBox(height: 10),
                      if (groubsize !=
                          null) // Conditionally render the group size row
                        buildInfoRow(Icons.people, groubsize!),
                      if (price !=
                          null) // Conditionally render the group size row
                        buildInfoRow(Icons.money, price.toString()),
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

  Row buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: ksecondcolor,
        ),
        SizedBox(width: 7),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ksecondcolor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
