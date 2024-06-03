import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:graduation/auth/cach/cach_helper.dart';
import 'package:graduation/auth/core_login/api/dio_consumer.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';
import 'package:graduation/auth/models/loginmodel.dart';
import 'package:graduation/auth/models/signupmodel.dart';
import 'package:graduation/auth/models/user_model.dart';
import 'package:graduation/core/errors/failures.dart';

import 'package:jwt_decoder/jwt_decoder.dart';

class UserRepository {
  final Diocosumer diocosumer;

  UserRepository({required this.diocosumer});
  Future<Either<String, SignInModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await diocosumer.post(
        endPoint.signin,
        data: {
          apikey.email: email,
          apikey.password: password,
        },
      );
      final user = SignInModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      log(decodedToken['id']);
      CacheHelper().saveData(key: apikey.token, value: user.token);
      CacheHelper().saveData(key: apikey.id, value: decodedToken[apikey.id]);
      return Right(user);
    } on Failure catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SignUpModel>> signUp({
    required String password,
    required String name,
    required String confirmPassword,
    required String email,
  }) async {
    try {
      final response = await diocosumer.post(
        endPoint.signup,
        data: {
          apikey.name: name,
          apikey.password: password,
          apikey.confrimpassword: confirmPassword,
          apikey.email: email,
        },
      );
      final signUPModel = SignUpModel.fromJson(response);
      return Right(signUPModel);
    } on Failure catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, userModel>> getUserProfile() async {
    try {
      final response = await diocosumer.get(
        endPoint.getUserDataEndPoint(
          CacheHelper().getData(key: apikey.id),
        ),
      );
      return Right(userModel.fromJson(response));
    } on ServerFailure catch (e) {
      return Left(e.toString());
    }
  }
}
