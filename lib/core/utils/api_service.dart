import 'package:dio/dio.dart';

class ApiService {
  final _baseurl = 'http://192.168.1.4:8000/api/v1/';
  final Dio _dio;

  ApiService(this._dio) {
    _dio.options.baseUrl = _baseurl;
    _dio.options.connectTimeout = const Duration(milliseconds: 20000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 20000);
  }

  Future<Map<String, dynamic>> get(
      {required String endpoint, String? search, Options? Headers}) async {
    var response = await _dio.get(
      endpoint,
      queryParameters: {'search': search},
      options: Headers,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endpoint, Options? Headers, dynamic body}) async {
    var response = await _dio.post(endpoint, options: Headers, data: body);
    return response.data;
  }

  Future<Map<String, dynamic>> delete(
      {required String endpoint, Options? headers}) async {
    var response = await _dio.delete(endpoint, options: headers);
    return response.data;
  }
}
