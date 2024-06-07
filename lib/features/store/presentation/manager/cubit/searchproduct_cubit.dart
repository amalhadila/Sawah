import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';
import 'package:graduation/features/store/presentation/manager/cubit/searchproduct_state.dart';

class SearchproductCubit extends Cubit<SearchproductStates> {
  SearchproductCubit(this.searchRepo) : super(SearchResultInitialState());
  final proCategoriesRepo searchRepo;

  Future fetchSearchResult({required String name}) async {
    emit(SearchproductLoading());
    var result = await searchRepo.fetchSearchResults(name: name);
    result.fold(
      (failure) {
        emit(SearchproductFailure(failure.message));
        print(failure.message);
      },
      (result) {
        print(result);
        emit(SearchproductSuccess(result));
      },
    );
  }
}
