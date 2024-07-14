import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/auth/cubit/user_state.dart';
import 'package:sawah/auth/repos/user_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/auth/repos/user_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

// user_cubit.dart

import '../cach/cach_helper.dart';
import '../core_login/api/end_point.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository userRepository;
  final CacheHelper cacheHelper;

  UserCubit(this.userRepository, this.cacheHelper) : super(UserInitial());

  // Sign in email and password controllers
  final TextEditingController signInEmail = TextEditingController();
  final TextEditingController signInPassword = TextEditingController();
  XFile? profilepic;
  // Sign up form controllers
  final TextEditingController signUpName = TextEditingController();
  final TextEditingController signUpEmail = TextEditingController();
  final TextEditingController signUpPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController signUpNameguide = TextEditingController();
  final TextEditingController signUpEmailguide = TextEditingController();
  final TextEditingController signUpPasswordguide = TextEditingController();
  final TextEditingController confirmPasswordguide = TextEditingController();

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
Future<void> signUpGuide() async {
  emit(SignUpLoadingguide());
  final response = await userRepository.signUpguide(
    name: signUpNameguide.text,
    email: signUpEmailguide.text,
    password: signUpPasswordguide.text,
    confirmPassword: confirmPasswordguide.text,
    role: 'guide',
  );
  response.fold(
    (errorMessage) {
      emit(SignUpFailureGuide(errorMessage));
    },
    (signUpModel) {
      emit(SignUpSuccessguide(signUpModel));
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

  void logout() async {
    try {
      // Use the instance method to remove the token
  final prefs = await SharedPreferences.getInstance();
      await prefs.remove(apikey.token); // Remove the token
      await prefs.remove(apikey.id); 
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserLogoutFailed(e.toString()));
    }
  }
}
