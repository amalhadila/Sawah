import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';

import '../screens/sign_in_screen.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Already have an account ? ',
            style: TextStyle(
                fontSize: 13,
                color: Color(0xff939393),
                fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: () => {Navigator.push(context,     MaterialPageRoute(builder: (context) => SignInScreen()),)},
            child: const Text(
              'Log-in',
              style: TextStyle(
                  fontSize: 15,
                  color: ksecondcolor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
