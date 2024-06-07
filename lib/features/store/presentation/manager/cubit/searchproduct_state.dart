import 'package:graduation/features/store/data/product/product.dart';

sealed class SearchproductStates {
  const SearchproductStates();
}

class SearchResultInitialState extends SearchproductStates {}

class SearchproductLoading extends SearchproductStates {}

class SearchproductSuccess extends SearchproductStates {
  final List<Product> product;

  const SearchproductSuccess(this.product);
}

class SearchproductFailure extends SearchproductStates {
  final String errorMessage;

  const SearchproductFailure(this.errorMessage);
}
