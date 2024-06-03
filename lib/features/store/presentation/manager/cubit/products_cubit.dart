import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/cart_item/product.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.catrepo) : super(ProductsInitial());
  final proCategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchProducts({required String categoryId}) async {
    if (_closed) return;
    print('Fetching product categories...');
    emit(ProductLoading());
    var result = await catrepo.fetchProducts(categoryId: categoryId);
    result.fold((Failure) {
      print('Failed to fetch product categories: ${Failure.message}');
      if (!_closed) emit(ProductFailure(Failure.message));
    }, (product_list) {
      print('Successfully fetched product categories');
      if (!_closed) emit(ProductSuccess(product_list));
    });
  }
}
