import 'package:dartz/dartz.dart';
import 'package:sawah/auth/core_login/errors/excpetion.dart';
import 'package:sawah/features/chatbot/data/models/conversationmodel/conversationmodel.dart';

abstract class Repo {
  Future<Either<Failure, List<Conversationmodel>>> fetchChatbotmessage();
  
Future SendMessageRequest(
      {required var text});
 Future  Deletechatbot();
}
