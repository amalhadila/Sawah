part of 'fetchwishlist_cubit.dart';

sealed class FetchwishlistState extends Equatable {
  const FetchwishlistState();

  @override
  List<Object> get props => [];
}

final class FetchwishlistInitial extends FetchwishlistState {}

class FetchwishlistLoading extends FetchwishlistState {}

class FetchwishlistFailure extends FetchwishlistState {
  final String errMessage;

  const FetchwishlistFailure(this.errMessage);
}

class FetchwishlistSuccess extends FetchwishlistState {
  final List<Wishlistitem> wishlist;

  const FetchwishlistSuccess(this.wishlist);
}
