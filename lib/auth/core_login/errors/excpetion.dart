import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  const Failure(this.errorMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errorMessage);

  factory ServerFailure.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('Receive timeout with Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to ApiServer was canceld');

      case DioExceptionType.connectionError:
        return ServerFailure('Request to ApiServer Connection Error');
      case DioExceptionType.unknown:
        return ServerFailure('Opps There was an Error, Please try again');

      default:
        return ServerFailure('Opps There was an Error, Please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response['errors'] != null &&
          response['errors']["password"] != null) {
        return ServerFailure(response['errors']["password"].first);
      } else if (response['errors'] != null &&
          response['errors']["username"] != null) {
        return ServerFailure(response['errors']["username"].first);
      } else {
        return ServerFailure("you don't have permission to access this page");
      }
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Server error, Please try later');
    } else if (response is Map && response.keys.contains("errors")) {
      return ServerFailure(response['errors'] is String
          ? response['errors']
          : response['errors'].values.first is String
              ? response['errors'].values.first
              : response['errors'].values.first.first);
    } else {
      return ServerFailure(' There was an Error,  try again');
    }
  }
}
