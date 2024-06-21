import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/auth/cubit/user_state.dart';
import 'package:graduation/auth/repos/user_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/auth/repos/user_repo.dart';
import 'package:image_picker/image_picker.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitial());

  // Sign in email and password controllers
  final TextEditingController signInEmail = TextEditingController();
  final TextEditingController signInPassword = TextEditingController();
  XFile? profilepic;
  // Sign up form controllers
  final TextEditingController signUpName = TextEditingController();
  final TextEditingController signUpEmail = TextEditingController();
  final TextEditingController signUpPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  uploadprofilepict(XFile image) {
    profilepic = image;
    emit(Updatephotoloading());
  }
  

  Future<void> signIn() async {
    emit(SignInLoading());
    final response = await userRepository.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );
    response.fold(
      (errorMessage) {
        emit(SignInFailure(errorMessage));
      },
      (signInModel) {
        emit(SignInSuccess());
      },
    );
  }

  Future<void> signUp() async {
    emit(SignUpLoading());
    final response = await userRepository.signUp(
      name: signUpName.text,
      email: signUpEmail.text,
      password: signUpPassword.text,
      confirmPassword: confirmPassword.text,
    );
    response.fold(
      (errorMessage) {
        emit(SignUpFailure(errorMessage));
      },
      (signUpModel) {
        emit(SignUpSuccess());
      },
    );
  }

  Future<void> getUserProfile() async {
    emit(GetUserLoading());
    final response = await userRepository.getUser();
    response.fold(
      (errorMessage) {
        emit(GetUserFailure(errorMessage));
      },
      (user) {
        emit(GetUserSuccess(user));
      },
    );
  }

  Future<void> uploadphoto() async {
    emit(GetUserLoading());
    final response = await userRepository.getUser();
    response.fold(
      (errorMessage) {
        emit(GetUserFailure(errorMessage));
      },
      (user) {
        emit(GetUserSuccess(user));
      },
    );
  }

  void uploadProfilePicture(XFile image) {}
}
