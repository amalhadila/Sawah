import 'package:bloc/bloc.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';
import 'package:graduation/features/store/presentation/manager/cubit/productbyid_state.dart';

class ProductbyidCubit extends Cubit<productbyidState> {
  ProductbyidCubit(this.catrepo) : super(productbyidInitial());
  final proCategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchProductbyId({required String productId}) async {
    if (_closed) return;
    print('Fetching product ...');
    emit(ProductbyLoading());
    var result = await catrepo.fetchProductbyId(productId: productId);
    result.fold((Failure) {
      print('Failed to fetch product : ${Failure.message}');
      if (!_closed) emit(ProductbyFailure(Failure.message));
    }, (product) {
      print('Successfully fetched product ');
      if (!_closed) emit(productbyiduccess(product));
    });
  }
}