part of 'chatbotmessage_cubit.dart';

sealed class ChatbotmessageState extends Equatable {
  const ChatbotmessageState();

  @override
  List<Object> get props => [];
}

final class ChatbotmessageInitial extends ChatbotmessageState {}

class ChatbotmessageLoading extends ChatbotmessageState {}

class ChatbotmessageFailure extends ChatbotmessageState {
  final String errMessage;

  const ChatbotmessageFailure(this.errMessage);
}

class ChatbotmessageSuccess extends ChatbotmessageState {
  final List<Conversationmodel> chatbotconversation;

  const ChatbotmessageSuccess(this.chatbotconversation);
}
