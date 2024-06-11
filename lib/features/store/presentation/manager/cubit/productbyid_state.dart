import 'package:equatable/equatable.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/data/productbyid/productbyid.dart';

sealed class productbyidState extends Equatable {
  const productbyidState();

  @override
  List<Object> get props => [];
}

final class productbyidInitial extends productbyidState {}

class ProductbyLoading extends productbyidState {}

class ProductbyFailure extends productbyidState {
  final String errMessage;

  const ProductbyFailure(this.errMessage);
}

class productbyiduccess extends productbyidState {
  final Product product;

  const productbyiduccess(this.product);
}
