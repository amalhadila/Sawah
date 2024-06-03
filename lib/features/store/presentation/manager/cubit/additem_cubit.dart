import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';

part 'additem_state.dart';

class AdditemCubit extends Cubit<AdditemState> {
  final proCategoriesRepo procategoriesRepo;
  AdditemCubit(this.procategoriesRepo) : super(AdditemInitial());

  Future<void> addItemToCart({required var id, required var quantity}) async {
    emit(AdditemLoading());

    try {
      await procategoriesRepo.addproduct(id: id, quantity: quantity);
      emit(AdditemSuccess());
    } catch (Failure) {
      emit(AdditemFailure(Failure.toString()));
    }
  }
}
