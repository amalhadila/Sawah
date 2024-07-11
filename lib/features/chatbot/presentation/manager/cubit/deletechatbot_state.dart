part of 'deletechatbot_cubit.dart';

sealed class DeletechatbotState extends Equatable {
  const DeletechatbotState();

  @override
  List<Object> get props => [];
}

final class DeletechatbotInitial extends DeletechatbotState {}

class DeletechatbotLoading extends DeletechatbotState {}

class DeletechatbotFailure extends DeletechatbotState {
  final String errMessage;

  const DeletechatbotFailure(this.errMessage);
}

class DeletechatbotSuccess extends DeletechatbotState {}
