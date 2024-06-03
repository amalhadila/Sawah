import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<dynamic> get(String path,
      {Object? data, Map<String, dynamic>? queryParametres});
  Future<dynamic> post(String path,
      {Object? data, Map<String, dynamic>? queryParametres});
  Future<dynamic> delete(String path,
      {Object? data, Map<String, dynamic>? queryParametres});
  // Future<dynamic> patch(String path,
  //     {Object? data, Map<String, dynamic>? queryParametres});
}
