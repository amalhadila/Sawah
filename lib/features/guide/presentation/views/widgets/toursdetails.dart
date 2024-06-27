import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/guide/presentation/views/widgets/send_price.dart';

class TourDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text('Tour Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tour name:', style: TextStyle(fontSize: 24,color: kmaincolor)),
            SizedBox(height: 20),
            Text('Details about the tour will be shown here.', style: TextStyle(fontSize: 18,color: kmaincolor)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => SendPriceScreen()),
  );
              },
              child: Text('Send Price',style: TextStyle(color: kbackgroundcolor,fontWeight: FontWeight.w600),),
            style: ElevatedButton.styleFrom(
                        backgroundColor: kmaincolor,
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
