import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation/auth/forgotpassword/default_button_widget.dart';
import 'package:graduation/auth/forgotpassword/default_form_field.dart';
import 'package:graduation/auth/forgotpassword/otp_page.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

Color primary = const Color(0x6A00BF);

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(backgroundColor: Colors.white,),
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .2,
            ),
            forgetPassTexts(),
            SizedBox(
              height: MediaQuery.of(context).size.height * .08,
            ),
            formField(
              controller: _emailController,
              hint: "Enter the email adress ",
            ),
            const SizedBox(
              height: 60,
            ),
            DefaultButtonWidget(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OTPPage(),
                  )),
              color: Colors.orange,
              text: "Continue",
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget formField(
      {String title = '',
      required String hint,
      required TextEditingController controller,
      Widget? suffixIcon,
      bool obscureText = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        if (title.isNotEmpty)
          const SizedBox(
            height: 10,
          ),
        DefaultFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          hintText: hint,
          suffixIcon: suffixIcon,
          obscureText: obscureText,
        ),
      ],
    );
  }

  Widget forgetPassTexts() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Forgot Password ?",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: Colors.orange,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Don't worry, it happens. please enter the email we will send the OTP in this email",
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
