import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/categories/data/repos/categories_repo.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';

part 'most_visited_state.dart';

class MostVisitedCubit extends Cubit<MostVisitedState> {
  MostVisitedCubit(this.mostvisitedrepo) : super(MostVisitedInitial());
  final CategoriesRepo mostvisitedrepo;
  Future<void> fetchmostvisited() async {
    emit(MostVisitedLoading());
    var result = await mostvisitedrepo.fetchmostvisited();
    result.fold((Failure) {
      emit(MostVisitedFailure(Failure.message));
    }, (mostvisited) {
      emit(MostVisitedSuccess(mostvisited));
    });
  }
}


