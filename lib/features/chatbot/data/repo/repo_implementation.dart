import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:googleapis/fcm/v1.dart';
import 'package:sawah/auth/cach/cach_helper.dart';
import 'package:sawah/auth/core_login/api/end_point.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/api_service.dart';
import 'package:sawah/features/chatbot/data/models/conversationmodel/conversationmodel.dart';
import 'package:sawah/features/chatbot/data/repo/repo.dart';

import '../../../../auth/core_login/errors/excpetion.dart';

class RepoImple implements Repo {
  final ApiService apiService;

  RepoImple(this.apiService);

  @override
  Future<Either<Failure, List<Conversationmodel>>> fetchChatbotmessage() async {
    try {
      var response = await apiService.get(
        endpoint: 'chatbot',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjRlMmY4ZmI4MTRiNTZmYTE4NSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzE5NzcwMTM1LCJleHAiOjE3Mjc1NDYxMzV9._bnZKiVF_39sfoYr5-x84DHhXHT8LksMJvalH79_Bzs',
          },
        ),
      );

      // Print response to check its structure
      print('Received data: ${response['doc']['chatbotConversation']}');

      Conversationmodel? data;
      if (response['doc']['chatbotConversation'] is Map<String, dynamic>) {
        data =
            Conversationmodel.fromJson(response['doc']['chatbotConversation']);
      } else if (response['doc']['chatbotConversation'] is Iterable) {
        for (var item in response['doc']['chatbotConversation']) {
          data = Conversationmodel.fromJson(item);
        }
      } else {
        throw Exception('Unexpected data structure');
      }

      if (data != null) {
        return right([data]);
      } else {
        throw Exception('Product not found');
      }
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDioError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future SendMessageRequest({required var text}) async {
    try {
      var data = await apiService.post(
        endpoint: 'chatbot/send-message',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjRlMmY4ZmI4MTRiNTZmYTE4NSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzE5NzcwMTM1LCJleHAiOjE3Mjc1NDYxMzV9._bnZKiVF_39sfoYr5-x84DHhXHT8LksMJvalH79_Bzs',
            'Content-Type': 'application/json'
          },
        ),
        body: {
          "text": text,
        },
      );
      print(data);
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.toString()}');
        throw ServerFailure.fromDioError(e);
      } else {
        print('ServerFailure: ${e.toString()}');
        throw ServerFailure(e.toString());
      }
    }
  }

  Future Deletechatbot() async {
    try {
      var response = await apiService.delete(
        endpoint: 'chatbot/clear',
        headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}',
          },
        ),
      );
      print('Response: ${response}');
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.toString()}');
        print('Response data: ${e.response?.data}');
        throw ServerFailure.fromDioError(e);
      } else {
        print('ServerFailure: ${e.toString()}');
        throw ServerFailure(e.toString());
      }
    }
  }
}
