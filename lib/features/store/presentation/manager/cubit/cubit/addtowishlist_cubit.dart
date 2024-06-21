import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';

part 'addtowishlist_state.dart';

class AddtowishlistCubit extends Cubit<AddtowishlistState> {
  final proCategoriesRepo procategoriesRepo;

  AddtowishlistCubit(this.procategoriesRepo) : super(AddtowishlistInitial());

  Future<void> addproducttowishlist({required var tourId}) async {
    emit(AddtowishlistLoading());

    try {
      await procategoriesRepo.addproducttowishlist(tourId: tourId);
      emit(AddtowishlistSuccess());
    } catch (Failure) {
      emit(AddtowishlistFailure(Failure.toString()));
    }
  }
}
