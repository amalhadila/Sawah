import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/chatbot/data/repo/repo.dart';

part 'sendmesage_state.dart';

class SendmesageCubit extends Cubit<SendmesageState> {
  SendmesageCubit(this.SendmesageRepo) : super(SendmesageInitial());
final Repo SendmesageRepo;


  Future<void> SendMessageRequest({required var messsagetext}) async {
    emit(SendmesageLoading());

    try {
      await SendmesageRepo.SendMessageRequest(text: messsagetext);
      emit(SendmesageSuccess());
    } catch (Failure) {
      emit(SendmesageFailure(Failure.toString()));
    }
  }
}
