import 'package:graduation/auth/core_login/api/end_point.dart';

class ErorModel {
  final int status;
  final String erorMessage;

  ErorModel({required this.status, required this.erorMessage});
  factory ErorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErorModel(
        erorMessage: jsonData[apikey.message],
        status: jsonData['error']['statusCode']);
  }
}
