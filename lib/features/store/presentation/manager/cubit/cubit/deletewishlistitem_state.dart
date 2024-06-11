part of 'deletewishlistitem_cubit.dart';

sealed class DeletewishlistitemState extends Equatable {
  const DeletewishlistitemState();

  @override
  List<Object> get props => [];
}

final class DeletewishlistitemInitial extends DeletewishlistitemState {}

class deletewishlistitemLoading extends DeletewishlistitemState {}

class deletewishlistitemFailure extends DeletewishlistitemState {
  final String errMessage;

  const deletewishlistitemFailure(this.errMessage);
}

class deletewishlistitemSuccess extends DeletewishlistitemState {}
