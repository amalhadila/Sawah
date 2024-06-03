part of 'products_cubit.dart';

sealed class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

final class ProductsInitial extends ProductsState {}

class ProductLoading extends ProductsState {}

class ProductFailure extends ProductsState {
  final String errMessage;

  const ProductFailure(this.errMessage);
}

class ProductSuccess extends ProductsState {
  final List<Product> product_list;

  const ProductSuccess(this.product_list);
}
