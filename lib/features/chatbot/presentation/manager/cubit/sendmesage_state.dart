part of 'sendmesage_cubit.dart';

sealed class SendmesageState extends Equatable {
  const SendmesageState();

  @override
  List<Object> get props => [];
}

final class SendmesageInitial extends SendmesageState {}
class SendmesageLoading extends SendmesageState {}

class SendmesageFailure extends SendmesageState {
  final String errMessage;

  const SendmesageFailure(this.errMessage);
}

class SendmesageSuccess extends SendmesageState {}
