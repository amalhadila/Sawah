import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sawah/features/chatbot/data/repo/repo.dart';

part 'deletechatbot_state.dart';

class DeletechatbotCubit extends Cubit<DeletechatbotState> {
  DeletechatbotCubit(this.repo) : super(DeletechatbotInitial());
  final Repo repo;

  Future<void> deletechatbot() async {
    emit(DeletechatbotLoading());
    try {
      await repo.Deletechatbot();
      emit(DeletechatbotSuccess());
    } catch (e) {
      emit(DeletechatbotFailure(e.toString()));
    }
  }
}
