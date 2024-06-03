import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/features/store/data/cart_item/product.dart';
import 'package:graduation/features/store/data/pro_cat.dart';
import 'package:graduation/features/store/data/product/product.dart';

abstract class proCategoriesRepo {
  Future<Either<Failure, List<ProCat>>> fetchProductCat();
  Future<Either<Failure, List<Product>>> fetchProducts(
      {required String categoryId});
  Future<Either<Failure, List<cartProduct>>> fetchcartitems();
  Future addproduct({required var id, required var quantity});
  Future deleteitem({required var Id});
}
