import 'package:dio/dio.dart';

class ApiService {
  final _baseurl = 'http://192.168.1.7:8000/api/v1/';
  final Dio _dio;
  
  ApiService(this._dio) {
    _dio.options.baseUrl = _baseurl;
    _dio.options.connectTimeout =  Duration(milliseconds: 20000);
    _dio.options.receiveTimeout =  Duration(milliseconds: 20000);
  }

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get(endpoint);
    return response.data;
  }
}
