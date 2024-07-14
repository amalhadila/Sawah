import 'package:sawah/auth/models/user_model.dart';
import 'package:sawah/auth/models/userdatamodel.dart';

import '../models/signupguidemodel.dart';


abstract class UserState {
  get user => null;
}

class UserInitial extends UserState {}

class SignInLoading extends UserState {}

class SignInSuccess extends UserState {}

class SignInFailure extends UserState {
  final String errorMessage;
  SignInFailure(this.errorMessage);
}

class LoadingStopped extends UserState {}

class SignUpLoading extends UserState {}

class SignUpSuccess extends UserState {}

class SignUpFailure extends UserState {
  final String errorMessage;
  SignUpFailure(this.errorMessage);
}
class SignUpLoadingguide extends UserState {}

class SignUpSuccessguide extends UserState {
  final SignUpGuideModel signUpModel;
  SignUpSuccessguide(this.signUpModel);
}


class SignUpFailureGuide extends UserState {
  final String errorMessage;
  SignUpFailureGuide(this.errorMessage);
}

class GetUserLoading extends UserState {}

class GetUserSuccess extends UserState {
  final userdatamodel user;
  GetUserSuccess(this.user);
}

class GetUserFailure extends UserState {
  final String errorMessage;
  GetUserFailure(this.errorMessage);
}

class Updatephotoloading extends UserState {}

class Updatephotoscuess extends UserState {
  final userdatamodel user;
  Updatephotoscuess(this.user);
}

class Updatephotofailure extends UserState {
  final String errorMessage;
  Updatephotofailure(this.errorMessage);
}
class UserLoggedOut extends UserState {
 
}

class UserLogoutFailed extends UserState {
  final String errorMessage;
  UserLogoutFailed(  this.errorMessage);
}
