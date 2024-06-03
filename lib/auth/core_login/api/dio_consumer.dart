import 'package:dio/dio.dart';
import 'package:graduation/auth/core_login/api/api_intercpetors.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';
import 'package:graduation/auth/core_login/errors/excpetion.dart';
import 'package:graduation/auth/cach/cach_helper.dart';  // Ensure this import for token retrieval

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
      error: true,
    ));
    dio.options.connectTimeout = const Duration(milliseconds: 20000);
    dio.options.receiveTimeout = const Duration(milliseconds: 20000);
  }

  Future<Map<String, String>> _getHeaders() async {
    final token = CacheHelper().getData(key: apikey.token);
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  Future<dynamic> delete(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _getHeaders()),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: await _getHeaders()),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<dynamic> patch(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _getHeaders()),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<dynamic> post(String path, {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: await _getHeaders()),
      );
      return response.data;
    } on DioException catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}