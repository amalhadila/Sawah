import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/auth/cubit/user_cubit.dart';
import 'package:graduation/auth/cubit/user_state.dart';
import 'package:graduation/auth/screens/profile_screen.dart';
import 'package:graduation/auth/widgets/custom_form_button.dart';
import 'package:graduation/auth/widgets/custom_input_field.dart';
import 'package:graduation/auth/widgets/dont_have_an_account.dart';
import 'package:graduation/auth/widgets/forget_password_widget.dart';
import 'package:graduation/auth/widgets/page_heading.dart';
import 'package:graduation/features/bottom_app_bar/bottom_app_bar.dart';
import 'package:graduation/features/home/pres/views/widget/homeview_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
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
            SnackBar(content: Text('Incorrect email or password')),
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
                  height: size.height * .25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const PageHeading(title: 'Welcome Back !'),
                      SizedBox(height: size.height * .03),
                      CustomInputField(
                        hintText: 'Your email',
                        controller: context.read<UserCubit>().signInEmail,
                      ),
                      SizedBox(height: size.height * .04),
                      CustomInputField(
                        hintText: 'Your password',
                        obscureText: true,
                        suffixIcon: true,
                        controller: context.read<UserCubit>().signInPassword,
                      ),
                      SizedBox(height: size.height * .04),
                      ForgetPasswordWidget(size: size),
                      const SizedBox(height: 20),
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is SignInLoading) {
                            return CircularProgressIndicator();
                          }
                          return CustomFormButton(
                            innerText: 'Sign In',
                            onPressed: () {
                              context.read<UserCubit>().signIn();
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 18),
                      DontHaveAnAccountWidget(size: size),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
