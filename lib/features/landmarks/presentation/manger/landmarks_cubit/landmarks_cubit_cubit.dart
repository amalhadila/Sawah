import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/landmarks/data/repos/categories_repo.dart';

part 'landmarks_cubit_state.dart';

class LandmarksCubitCubit extends Cubit<LandmarksCubitState> {
  LandmarksCubitCubit(this.landmarkrepo) : super(LandmarksCubitInitial());
  final CategoriesRepo landmarkrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchlandmarks({required String categoryId}) async {
    if (_closed) return;
    emit(LandmarksCubitLoading());
    var result = await landmarkrepo.fetchlandmarks(categoryId: categoryId);
    result.fold((Failure) {
      if (!_closed) emit(LandmarksCubitFailure(Failure.message));
    }, (lamdmarks) {
      if (!_closed) emit(LandmarksCubitSuccess(lamdmarks));
    });
  }
}
