import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sawah/features/store/data/repo/pro_cat_repo.dart';
import 'package:sawah/features/store/data/wishlistitem.dart';

part 'fetchwishlist_state.dart';

class FetchwishlistCubit extends Cubit<FetchwishlistState> {
  FetchwishlistCubit(this.catrepo) : super(FetchwishlistInitial());
  final proCategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<dynamic> fetchwishlist() async {
    if (_closed) return;
    emit(FetchwishlistLoading());
    var result = await catrepo.fetchwishlist();
    result.fold((Failure) {
      if (!_closed) emit(FetchwishlistFailure(Failure.message));
    }, (wishlist) {
      print(wishlist);
      if (!_closed) emit(FetchwishlistSuccess(wishlist));
      return wishlist;
    });
  }
}
