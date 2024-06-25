import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/landmarks/data/repos/categories_repo.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';
part 'most_visited_state.dart';

class MostVisitedCubit extends Cubit<MostVisitedState> {
  MostVisitedCubit(this.mostvisitedrepo) : super(MostVisitedInitial());
  final CategoriesRepo mostvisitedrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchmostvisited() async {
    if (_closed) return;
    emit(MostVisitedLoading());
    var result = await mostvisitedrepo.fetchmostvisited();
    result.fold((Failure) {
      if (!_closed) emit(MostVisitedFailure(Failure.message));
    }, (mostvisited) {
      if (!_closed) emit(MostVisitedSuccess(mostvisited));
    });
  }
}
