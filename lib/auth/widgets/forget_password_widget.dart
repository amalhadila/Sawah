import 'package:flutter/material.dart';
import 'package:sawah/auth/forgotpassword/forgot_password_page.dart';
import 'package:sawah/constants.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.80,
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ForgetPasswordPage(),
            ),
          )
        },
        child: const Text(
          'Forget password?',
          style: TextStyle(
            color: ksecondcolor,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
