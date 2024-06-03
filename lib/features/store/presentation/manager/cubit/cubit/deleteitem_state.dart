part of 'deleteitem_cubit.dart';

sealed class DeleteitemState extends Equatable {
  const DeleteitemState();

  @override
  List<Object> get props => [];
}

final class DeleteitemInitial extends DeleteitemState {}

class DeleteitemLoading extends DeleteitemState {}

class DeleteitemFailure extends DeleteitemState {
  final String errMessage;

  const DeleteitemFailure(this.errMessage);
}

class DeleteitemSuccess extends DeleteitemState {}
