import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';
import '../../features/bottom_app_bar/bottom_app_bar.dart';
import '../../auth/cach/cach_helper.dart';
import '../core_login/api/end_point.dart';

class VerifyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Verify Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: abarcolor,
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: abarcolor, // Text color
            shadowColor: Colors.grey, // Shadow color
            elevation: 5, // Elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
          ),
          onPressed: () async {
            
            
            
            final response = await http.get(
              Uri.parse('https://sawahonline.com/api/v1/users/resendVerificationEmail'),
              headers: {
                'Authorization': 'Bearer ${CacheHelper().getData(key: apikey.token)}',
                'Content-Type': 'application/json',
              },
            );

            if (response.statusCode == 200) {
              final responseBody = json.decode(response.body);
              final message = responseBody['message'];
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
              if (responseBody['status'] == 'success') {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('An error occurred. Please try again later.')),
              );
            }
          },
          child: Text('Click here to verify',style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}
