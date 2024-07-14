import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sawah/auth/cach/cach_helper.dart';
import 'package:sawah/auth/core_login/api/dio_consumer.dart';
import 'package:sawah/auth/core_login/api/end_point.dart';
import 'package:sawah/auth/core_login/errors/excpetion.dart';
import 'package:sawah/auth/models/loginmodel.dart';
import 'package:sawah/auth/models/signupmodel.dart';
import 'package:sawah/auth/models/user_model.dart';
import 'package:sawah/auth/models/userdatamodel.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../constants.dart';
import '../models/reset_password_mode.dart';
import '../models/signupguidemodel.dart';

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
      print(apikey.token);
      log('tokem');
      CacheHelper().saveData(key: apikey.id, value: user.id);
      print(user.id);
      log('id');
      log('rrrrrrrrrr');
      CacheHelper().saveData(key: apikey.name, value: user.name);
      CacheHelper().saveData(key: apikey.role, value: user.role);
      CacheHelper().saveData(key: apikey.emailverify, value: user.emailverfy);
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

Future<Either<String, SignUpGuideModel>> signUpguide({
  required String password,
  required String name,
  required String confirmPassword,
  required String email,
  required String role,
}) async {
  try {
    final response = await diocosumer.post(
      endPoint.signup,
      data: {
        apikey.name: name,
        apikey.password: password,
        apikey.confrimpassword: confirmPassword,
        apikey.email: email,
        'role': role,
      },
    );

    // Print the response data to understand its structure
    print('Response data: ${response.data}');

    // Check and parse the response data
    if (response.data is Map<String, dynamic>) {
      final data = response.data as Map<String, dynamic>;

      if (data['status'] == 'success' && data['data'] != null && data['data']['user'] != null) {
        final signUPModel = SignUpGuideModel.fromJson(data['data']['user']);
        return Right(signUPModel);
      } else {
        return Left("Unexpected response structure or missing data");
      }
    } else {
      return Left("Response data is not a valid JSON");
    }
  } on Failure catch (e) {
    return Left(e.toString());
  } catch (e) {
    return Left("An unexpected error occurred: ${e.toString()}");
  }
}

  Future<Either<String, userdatamodel>> getUser() async {
    try {
      final response = await diocosumer.get(
          endPoint.getUserDataEndPoint(CacheHelper().getData(key: apikey.id)));
      return Right(userdatamodel.fromJson(response));
    } on Failure catch (e) {
      log('GetUser Error: ${e.toString()}');
      return Left(e.toString());
    }
  }

  Future<Either<String, ResetPasswordModel>> resetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await diocosumer.patch(
        endPoint.resetpassword,
        data: {
          apikey.password: password,
          apikey.confrimpassword: confirmPassword,
        },
      );
      final resetPassword = ResetPasswordModel.fromJson(response);
      return Right(resetPassword);
    } on Failure catch (e) {
      return Left(e.toString());
    }
  }
}
