import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/landmarks/data/model/categories_model.dart';
import 'package:graduation/features/landmarks/data/repos/categories_repo.dart';

part 'categories_cubit_state.dart';

class CategoriesCubitCubit extends Cubit<CategoriesCubitState> {
  CategoriesCubitCubit(this.catrepo) : super(CategoriesCubitInitial());
  final CategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchCategories() async {
    if (_closed) return;
    emit(CategoriesCubitLoading());
    var result = await catrepo.fetchCategories();
    result.fold((Failure) {
      if (!_closed) emit(CategoriesCubitFailure(Failure.message));
    }, (categories) {
      if (!_closed) emit(CategoriesCubitSuccess(categories));
    });
  }
}
