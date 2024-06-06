import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';

part 'deleteitem_state.dart';

class DeleteitemCubit extends Cubit<DeleteitemState> {
  DeleteitemCubit(this.procategoriesRepo) : super(DeleteitemInitial());

  final proCategoriesRepo procategoriesRepo;

  Future<void> deleteitem({required var Id}) async {
    emit(DeleteitemLoading());
    try {
      await procategoriesRepo.deleteitem(Id: Id);
      emit(DeleteitemSuccess());
    } catch (e) {
      emit(DeleteitemFailure(e.toString()));
    }
  }
}
