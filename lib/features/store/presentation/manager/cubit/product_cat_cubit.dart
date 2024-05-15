import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/pro_cat.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';

part 'product_cat_state.dart';

class ProductCatCubit extends Cubit<ProductCatState> {
  ProductCatCubit(this.catrepo) : super(ProductCatInitial());
  final proCategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchCategories() async {
    if (_closed) return;
    emit(ProductCatLoading());
    var result = await catrepo.fetchProductCat();
    result.fold((Failure) {
      if (!_closed) emit(ProductCatFailure(Failure.message));
    }, (pro_cat_list) {
      if (!_closed) emit(ProductCatSuccess(pro_cat_list));
    });
  }
}
