import 'package:flutter/material.dart';

import '../../constants.dart';
import 'sign_up_screen.dart';
import 'signupscreanforguide.dart';





class SignupChoicePage extends StatelessWidget {
  void _navigateToSignupAsGuide(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Signupscreanforguide()),
    );
  }

  void _navigateToSignupAsTourist(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up' ,style: TextStyle(color: Colors.white),
        ),
        backgroundColor: abarcolor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: abarcolor, // Text color
            shadowColor: Colors.grey, // Shadow color
            elevation: 5, // Elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
          ),
              onPressed: () => _navigateToSignupAsTourist(context),
              child: Text('Sign Up as Tourist'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: abarcolor, // Text color
            shadowColor: Colors.grey, // Shadow color
            elevation: 5, // Elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
          ),
              onPressed: () => _navigateToSignupAsGuide(context),
              child: Text('Sign Up as Tour Guide'),
            ),
          ],
        ),
      ),
    );
  }
}




