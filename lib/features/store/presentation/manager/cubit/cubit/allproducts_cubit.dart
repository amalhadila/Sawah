import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';

part 'allproducts_state.dart';

class AllproductsCubit extends Cubit<AllproductsState> {
  AllproductsCubit(this.catrepo) : super(AllproductsInitial());
  final proCategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchallProducts() async {
    if (_closed) return;
    print('Fetching all product for category ...');
    emit(AllproductLoading());
    var result = await catrepo.fetchallProducts();
    result.fold((Failure) {
      print('Failed to fetch all product for category: ${Failure.message}');
      if (!_closed) emit(AllproductFailure(Failure.message));
    }, (product_list) {
      print('Successfully fetched all product for category');
      if (!_closed) emit(AllproductSuccess(product_list));
    });
  }
}
