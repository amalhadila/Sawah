import 'package:dio/dio.dart';
import 'package:graduation/auth/core_login/api/api_intercpetors.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';
import 'package:graduation/auth/core_login/errors/excpetion.dart';
import 'package:graduation/auth/cach/cach_helper.dart'; // Ensure this import for token retrieval

class Diocosumer {
  final Dio dio;

  Diocosumer({required this.dio}) {
    dio.options.baseUrl = endPoint.BaseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
     request: true,
     requestHeader: true,
     requestBody: true,
     responseHeader: true,
     responseBody: true,
     error: true
    
    ));
     dio.options.connectTimeout = const Duration(milliseconds: 200000);
    dio.options.receiveTimeout = const Duration(milliseconds: 50000);

  }

  Future delete(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.delete(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      // Catch  DioException instead of DioException
      throw ServerFailure(
          e.toString()); // Throw ServerFailure instead of returning it
    }
  }

  Future get(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path,
          queryParameters: queryParameters); // Use get method instead of post
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future patch(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await dio.patch(path, data: data, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future post(String path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(path,
          data: data,
          queryParameters: queryParameters); // Use post method instead of patch
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
