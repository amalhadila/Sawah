import 'package:graduation/auth/models/user_model.dart';

abstract class UserState {}

class UserInitial extends UserState {}


class SignInLoading extends UserState {}

class SignInSuccess extends UserState {}

class SignInFailure extends UserState {
  final String errorMessage;
  SignInFailure(this.errorMessage);
}
class  LoadingStopped extends UserState {}

class SignUpLoading extends UserState {}

class SignUpSuccess extends UserState {}

class SignUpFailure extends UserState {
  final String errorMessage;
  SignUpFailure(this.errorMessage);
}

class GetUserLoading extends UserState {}

class GetUserSuccess extends UserState {
  final userModel user;
  GetUserSuccess(this.user);
}

class GetUserFailure extends UserState {
  final String errorMessage;
  GetUserFailure(this.errorMessage);
}
