import 'package:graduation/auth/models/user_model.dart';
import 'package:graduation/auth/models/userdatamodel.dart';

abstract class UserState {}

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