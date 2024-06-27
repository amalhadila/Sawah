import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/guide/presentation/views/widgets/toursdetails.dart';
import 'package:graduation/features/guide/presentation/views/widgets/card.dart';

class TourListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text('Tour List'),
      ),
      body: ListView.builder(
        itemCount: 10, 
        itemBuilder: (context, index) {
          return GestureDetector(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal:35.0),
              child: guideCard(
                imageUrl:'assets/img/landmarks/amenemhatIIICover.jpg' ,
                landmarkname: 'pyramids',
                date: 'start and end date',
              ),
            ),
            onTap: () {
               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => TourDetailsScreen()),
  );
            },
          );
        },
      ),
    );
  }
}