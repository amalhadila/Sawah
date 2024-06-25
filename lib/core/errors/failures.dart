import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDiorError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with the API server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with the API server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with the API server');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate with the API server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            e.response?.statusCode ?? 0, e.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request to the API server was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('No internet connection');
      case DioExceptionType.unknown:
      default:
        return ServerFailure('Oops, there was an error. Please try again');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 404) {
      return ServerFailure('Your request was not found, please try later');
    } else if (statusCode == 500) {
      return ServerFailure('There is a problem with the server, please try later');
    } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      if (response != null && response is Map<String, dynamic>) {
        return ServerFailure(response['error']['message'] ?? 'Unauthorized request');
      } else {
        return ServerFailure('Unauthorized request');
      }
    } 
    else if (response is Map && response.keys.contains("errors")) {
      return ServerFailure(response['errors'] is String
          ? response['errors']
          : response['errors'].values.first is String
              ? response['errors'].values.first
              : response['errors'].values.first.first);
              }
              else {
      return ServerFailure('There was an error, please try again');
    }
  }
}
