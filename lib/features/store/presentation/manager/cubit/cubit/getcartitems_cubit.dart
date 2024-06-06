import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';
import 'package:graduation/features/store/data/usercart/usercart.dart';

part 'getcartitems_state.dart';

class GetcartitemsCubit extends Cubit<GetcartitemsState> {
  GetcartitemsCubit(this.catrepo) : super(GetcartitemsInitial());
  final proCategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchcartitems() async {
    if (_closed) return;
    emit(ProductLoading());
    var result = await catrepo.fetchcartitems();
    result.fold((Failure) {
      if (!_closed) emit(ProductFailure(Failure.message));
    }, (cartitems_list) {
      print(cartitems_list);
      if (!_closed) emit(ProductSuccess(cartitems_list));
    });
  }
}
