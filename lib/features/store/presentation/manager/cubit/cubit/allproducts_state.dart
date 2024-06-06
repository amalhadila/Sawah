part of 'allproducts_cubit.dart';

sealed class AllproductsState extends Equatable {
  const AllproductsState();

  @override
  List<Object> get props => [];
}

final class AllproductsInitial extends AllproductsState {}

class AllproductLoading extends AllproductsState {}

class AllproductFailure extends AllproductsState {
  final String errMessage;

  const AllproductFailure(this.errMessage);
}

class AllproductSuccess extends AllproductsState {
  final List<Product> product_list;

  const AllproductSuccess(this.product_list);
}
