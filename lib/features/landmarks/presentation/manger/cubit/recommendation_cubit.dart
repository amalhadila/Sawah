import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sawah/features/landmarks/data/repos/categories_repo.dart';
import 'package:sawah/features/store/data/product/product.dart';

part 'recommendation_state.dart';

class RecommendationCubit extends Cubit<RecommendationState> {
  RecommendationCubit(this.recommendationrepo) : super(RecommendationInitial());
  final CategoriesRepo recommendationrepo;

bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> recommendation({ String? landmarkId}) async {
    if (_closed) return;
    print('Fetching products ...');
    emit(RecommendationLoading());
    var result = await recommendationrepo.recommendation(landmarkId: landmarkId);
    result.fold((Failure) {
      print('Failed to fetch products : ${Failure.message}');
      if (!_closed) emit(RecommendationFailure(Failure.message));
    }, (product_list) {
       print(product_list);
      print('Successfully fetched products ');
      if (!_closed) emit(RecommendationSuccess(product_list));
    });
  }
}