import 'package:flutter/material.dart';
import 'package:graduation/features/guide/presentation/views/widgets/toursdetails.dart';
import 'package:graduation/features/guide/presentation/views/widgets/card.dart';

class TourListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour List'),
      ),
      body: ListView.builder(
        itemCount: 10, 
        itemBuilder: (context, index) {
          return ListTile(
            title: guideCard(
              imageUrl:'assets/img/landmarks/amenemhatIIICover.jpg' ,
              landmarkname: 'pyramids',
              date: 'start and end date',
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
