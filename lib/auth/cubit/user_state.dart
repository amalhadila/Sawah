class UserState {}

final class UserInitial extends UserState {}

final class signinsucces extends UserState {}

final class signinloading extends UserState {}

final class signinfailure extends UserState {
  final String erormesage;

  signinfailure({required this.erormesage});
}
