part of 'additem_cubit.dart';

sealed class AdditemState extends Equatable {
  const AdditemState();

  @override
  List<Object> get props => [];
}

final class AdditemInitial extends AdditemState {}

class AdditemLoading extends AdditemState {}

class AdditemFailure extends AdditemState {
  final String errMessage;

  const AdditemFailure(this.errMessage);
}

class AdditemSuccess extends AdditemState {}
