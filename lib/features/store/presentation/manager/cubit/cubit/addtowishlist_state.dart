part of 'addtowishlist_cubit.dart';

sealed class AddtowishlistState extends Equatable {
  const AddtowishlistState();

  @override
  List<Object> get props => [];
}

final class AddtowishlistInitial extends AddtowishlistState {}

class AddtowishlistLoading extends AddtowishlistState {}

class AddtowishlistFailure extends AddtowishlistState {
  final String errMessage;

  const AddtowishlistFailure(this.errMessage);
}

class AddtowishlistSuccess extends AddtowishlistState {}
