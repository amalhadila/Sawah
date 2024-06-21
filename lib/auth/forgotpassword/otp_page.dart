import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graduation/auth/forgotpassword/default_button_widget.dart';
import 'package:graduation/auth/forgotpassword/forgot_password_page.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({super.key});

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  late Timer _timer;
  int _start = 59;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pinController.dispose();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .22,
            ),
            verificationCodeTexts(),
            otpField(),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                _start > 0 ? "00:$_start Sec" : "Time expired. Resend code?",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (_start == 0)
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Logic to resend OTP
                    setState(() {
                      _start = 59;
                      startTimer();
                    });
                  },
                  child: const Text(
                    "Re-send",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 25,
            ),
            DefaultButtonWidget(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgetPasswordPage(),
                    ),
                  );
                }
              },
              color: Colors.orange,
              text: "Submit",
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget verificationCodeTexts() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "OTP Verification",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: Colors.orange,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Enter the OTP sent to email",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget otpField() {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      padding: const EdgeInsets.only(top: 7),
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.amber,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.amber),
        borderRadius: BorderRadius.circular(10),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.white,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Pinput(
        length: 6,
        keyboardType: TextInputType.number,
        controller: _pinController,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        textInputAction: TextInputAction.next,
        showCursor: true,
        validator: (value) {
          if (value?.isEmpty ?? true) {
            return "Required";
          }
          return null;
        },
        onCompleted: (pin) {
          print("Entered OTP: $pin");
        },
      ),
    );
  }
}
