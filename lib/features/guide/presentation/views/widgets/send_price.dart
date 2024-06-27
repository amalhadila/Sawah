import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';

class SendPriceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Send Price'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tour name: ', style: TextStyle(fontSize: 24,color: kmaincolor)),
            SizedBox(height: 20),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                labelText: 'Enter Price',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Price: ${priceController.text}');
              },
              child: Text('Send',style:TextStyle(color: kbackgroundcolor,fontWeight: FontWeight.w600),),
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