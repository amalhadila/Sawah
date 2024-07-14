import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/auth/cubit/user_cubit.dart';
import 'package:sawah/auth/cubit/user_state.dart';
import 'package:sawah/auth/widgets/already_have_an_account_widget.dart';
import 'package:sawah/auth/widgets/custom_form_button.dart';
import 'package:sawah/auth/widgets/custom_input_field.dart';
import 'package:sawah/auth/widgets/page_heading.dart';

class Signupscreanforguide extends StatelessWidget {
  const Signupscreanforguide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserCubit, UserState>(
  listener: (context, state) {
    if (state is SignUpSuccessguide) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful')),
      );
    } else if (state is SignUpFailureGuide) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful')),
      );
    }
  },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * .21,
                  ),
                  Column(
                    children: [
                      // const PageHeader(),
                      const PageHeading(
                          title: 'Hello!Register to get\n Started.'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .02),
                      CustomInputField(
                        hintText: 'Your name',
                        isDense: true,
                        controller: context.read<UserCubit>().signUpNameguide,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),
                      //!Email
                      CustomInputField(
                        hintText: 'Your email',
                        isDense: true,
                        controller: context.read<UserCubit>().signUpEmailguide,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),

                      //! Password
                      CustomInputField(
                        hintText: 'Your password',
                        isDense: true,
                        obscureText: true,
                        suffixIcon: true,
                        controller: context.read<UserCubit>().signUpPasswordguide,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),
                      //! Confirm Password
                      CustomInputField(
                        hintText: 'Confirm Your password',
                        isDense: true,
                        obscureText: true,
                        suffixIcon: true,
                        controller: context.read<UserCubit>().confirmPasswordguide,
                      ),
                      const SizedBox(height: 32),
                      //!Sign Up Button
                      state is SignUpLoadingguide
                          ? const CircularProgressIndicator()
                          : CustomFormButton(
                              innerText: 'Sign up',
                              onPressed: () {
                                context.read<UserCubit>().signUpGuide();
                              },
                            ),
                      const SizedBox(height: 18),
                      //! Already have an account widget
                      const AlreadyHaveAnAccountWidget(),
                      const SizedBox(height: 30),
                    ],
                  )
                ]),
          ),
        );
      },
    );
  }
}
