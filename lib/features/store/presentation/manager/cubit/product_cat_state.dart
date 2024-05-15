part of 'product_cat_cubit.dart';

sealed class ProductCatState extends Equatable {
  const ProductCatState();

  @override
  List<Object> get props => [];
}

final class ProductCatInitial extends ProductCatState {}

class ProductCatLoading extends ProductCatState {}

class ProductCatFailure extends ProductCatState {
  final String errMessage;

  const ProductCatFailure(this.errMessage);
}

class ProductCatSuccess extends ProductCatState {
  final List<ProCat> pro_cat_list;

  const ProductCatSuccess(this.pro_cat_list);
}
