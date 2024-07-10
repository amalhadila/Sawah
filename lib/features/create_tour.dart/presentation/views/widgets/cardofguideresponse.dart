import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';

class GuideCardrespond extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String price;
  
  const GuideCardrespond({
    Key? key,
    required this.imageUrl,
    required this.username,
    required this.price, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardHeight = screenWidth * 0.48; // Adjusted card height

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
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: secondaryColor1,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  SizedBox(width: 10),
                  Text(
                    username,
                    style: TextStyle(fontWeight: FontWeight.bold, color: kmaincolor),
                  ),
                ],
              ),
              SizedBox(height: 10), // Adjusted height
              Text(
                'Price: \$$price',
                style: TextStyle(fontWeight: FontWeight.bold, color: kmaincolor, fontSize: 18),
              ),
            // Adds space to push the button to the bottom
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your confirmation logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kmaincolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Confirm',
                    style: TextStyle(color: Colors.white),
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
