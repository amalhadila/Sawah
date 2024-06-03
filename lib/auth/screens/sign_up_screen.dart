import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/auth/cubit/user_cubit.dart';
import 'package:graduation/auth/cubit/user_state.dart';
import 'package:graduation/auth/widgets/already_have_an_account_widget.dart';
import 'package:graduation/auth/widgets/custom_form_button.dart';
import 'package:graduation/auth/widgets/custom_input_field.dart';
import 'package:graduation/auth/widgets/page_heading.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('success')));
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Incorrect email or password')));
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
                        controller: context.read<UserCubit>().signUpName,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),
                      //!Email
                      CustomInputField(
                        hintText: 'Your email',
                        isDense: true,
                        controller: context.read<UserCubit>().signUpEmail,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),

                      //! Password
                      CustomInputField(
                        hintText: 'Your password',
                        isDense: true,
                        obscureText: true,
                        suffixIcon: true,
                        controller: context.read<UserCubit>().signUpPassword,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .03),
                      //! Confirm Password
                      CustomInputField(
                        hintText: 'Confirm Your password',
                        isDense: true,
                        obscureText: true,
                        suffixIcon: true,
                        controller: context.read<UserCubit>().confirmPassword,
                      ),
                      const SizedBox(height: 32),
                      //!Sign Up Button
                      state is SignUpLoading
                          ? const CircularProgressIndicator()
                          : CustomFormButton(
                              innerText: 'Signup',
                              onPressed: () {
                                context.read<UserCubit>().signUp();
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
