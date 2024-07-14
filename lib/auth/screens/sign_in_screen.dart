import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/auth/cubit/user_cubit.dart';
import 'package:sawah/auth/cubit/user_state.dart';
import 'package:sawah/auth/screens/profile_screen.dart';
import 'package:sawah/auth/widgets/custom_form_button.dart';
import 'package:sawah/auth/widgets/custom_input_field.dart';
import 'package:sawah/auth/widgets/dont_have_an_account.dart';
import 'package:sawah/auth/widgets/forget_password_widget.dart';
import 'package:sawah/auth/widgets/page_heading.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/features/bottom_app_bar/bottom_app_bar.dart';
import 'package:sawah/features/home/pres/views/widget/homeview_body.dart';
import 'package:sawah/firebase/firedatabase.dart';

import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserCubit, UserState>(listener: (context, state) {
      if (state is SignInSuccess) {
        context.read<UserCubit>().getUserProfile();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BottomNavigation(),
          ),
        );
      } else if (state is SignInFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('uncorrect email or password')));
      }
    }, builder: (context, State) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * .25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const PageHeading(title: 'Welcome Back !'),
                    SizedBox(height: MediaQuery.of(context).size.height * .03),
                    //!Email
                    CustomInputField(
                      hintText: 'Your email',
                      controller: context.read<UserCubit>().signInEmail,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .04),
                    //!Password
                    CustomInputField(
                      hintText: 'Your password',
                      obscureText: true,
                      suffixIcon: true,
                      controller: context.read<UserCubit>().signInPassword,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .04),
                    //! Forget password?
                    ForgetPasswordWidget(size: size),
                    const SizedBox(height: 20),
                    //!Sign In Button
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        return state is SignInLoading
                            ? CircularProgressIndicator()
                            : CustomFormButton(
                                innerText: 'Sign In',
                                onPressed: () async {
                                  await context.read<UserCubit>().signIn();

                                  FirebaseMessaging.instance
                                      .requestPermission();
                                  await FirebaseMessaging.instance
                                      .getToken()
                                      .then((onValue) {
                                    if (onValue != null) {
                                      print('$onValue');
                                      FireData().createUser(onValue);
                                    }
                                  });
                                },
                              );
                      },
                    ),
                    const SizedBox(height: 18),
                    //! Dont Have An Account ?
                    DontHaveAnAccountWidget(size: size),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
