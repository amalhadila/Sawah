import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/features/store/data/cart_item/product.dart';
import 'package:graduation/features/store/data/pro_cat.dart';
import 'package:graduation/features/store/data/products/products.dart';

abstract class proCategoriesRepo {
  Future<Either<Failure, List<ProCat>>> fetchProductCat();
  Future<Either<Failure, List<Products>>> fetchProducts(
      {required String categoryId});
  Future<Either<Failure, List<Product>>> fetchcartitems();
  Future addproduct({required var id, required var quantity});
  Future deleteitem(
      {required var Id});
}
