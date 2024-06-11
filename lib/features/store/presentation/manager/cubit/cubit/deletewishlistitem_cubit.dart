import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';

part 'deletewishlistitem_state.dart';

class DeletewishlistitemCubit extends Cubit<DeletewishlistitemState> {
  DeletewishlistitemCubit(this.procategoriesRepo)
      : super(DeletewishlistitemInitial());
  final proCategoriesRepo procategoriesRepo;

  Future<void> deletewishlistitem({required var Id}) async {
    emit(deletewishlistitemLoading());
    try {
      await procategoriesRepo.deletewishlistitem(Id: Id);
      emit(deletewishlistitemSuccess());
    } catch (e) {
      emit(deletewishlistitemFailure(e.toString()));
    }
  }
}
