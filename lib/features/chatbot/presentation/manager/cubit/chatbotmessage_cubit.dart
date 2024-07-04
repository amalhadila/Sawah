import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/chatbot/data/models/conversationmodel/conversationmodel.dart';
import 'package:graduation/features/chatbot/data/repo/repo.dart';

part 'chatbotmessage_state.dart';

class ChatbotmessageCubit extends Cubit<ChatbotmessageState> {
  ChatbotmessageCubit(this.repo) : super(ChatbotmessageInitial());
  final Repo repo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchChatbotMessages() async {
    if (_closed) return;
    emit(ChatbotmessageLoading());
    var result = await repo.fetchChatbotmessage();
    result.fold((failure) {
      if (!_closed) emit(ChatbotmessageFailure(failure.errorMessage));
    }, (chatbotconversation) {
      if (!_closed) emit(ChatbotmessageSuccess(chatbotconversation));
    });
  }
}
