import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/auth/cubit/user_cubit.dart';
import 'package:graduation/auth/cubit/user_state.dart';

import 'package:graduation/auth/widgets/custom_form_button.dart';
import 'package:graduation/auth/widgets/custom_input_field.dart';
import 'package:graduation/auth/widgets/dont_have_an_account.dart';
import 'package:graduation/auth/widgets/forget_password_widget.dart';
import 'package:graduation/auth/widgets/page_heading.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is signinsucces) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('success')));
        
        }else if(state is signinfailure){
ScaffoldMessenger.of(context)
             .showSnackBar( SnackBar(content: Text('fail')));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xffEEF1F3),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * .25,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Form(
                    key: context.read<UserCubit>().signInFormKey,
                    child: Column(
                      children: [
                        const PageHeading(title: 'Sign-in'),
                        //!Email
                        CustomInputField(
                          labelText: 'Email',
                          hintText: 'Your email',
                          controller: context.read<UserCubit>().signInEmail,
                        ),
                        const SizedBox(height: 16),
                        //!Password
                        CustomInputField(
                          labelText: 'Password',
                          hintText: 'Your password',
                          obscureText: true,
                          suffixIcon: true,
                          controller:
                              context.read<UserCubit>().signInPassword,
                        ),
                        const SizedBox(height: 16),
                        //! Forget password?
                        ForgetPasswordWidget(size: size),
                        const SizedBox(height: 20),
                        //!Sign In Button
                        state is signinloading
                            ? CircularProgressIndicator()
                            : CustomFormButton(
                                innerText: 'Sign In',
                                onPressed: () {
                                  context.read<UserCubit>().SignIn();
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => const ProfileScreen(),
                                  //   ),
                                  // );
                                },
                              ),
                        const SizedBox(height: 18),
                        //! Dont Have An Account ?
                        DontHaveAnAccountWidget(size: size),
                        const SizedBox(height: 20),
                      ],
                    ),
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
