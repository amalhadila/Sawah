import 'package:dartz/dartz.dart';
import 'package:sawah/core/errors/failures.dart';
import 'package:sawah/features/store/data/pro_cat.dart';
import 'package:sawah/features/store/data/product/product.dart';
import 'package:sawah/features/store/data/usercart/usercart.dart';
import 'package:sawah/features/store/data/wishlistitem.dart';

abstract class proCategoriesRepo {
  Future<Either<Failure, List<ProCat>>> fetchProductCat();
  Future<Either<Failure, bool>> checkAvailability(
      {required var tourId, required var groupSize, required var tourDate});
  Future<Either<Failure, Product>> fetchProductbyId(
      {required String productId});
  Future<Either<Failure, List<Product>>> fetchProducts(
      {required String categoryId});

  Future<Either<Failure, List<Product>>> fetchallProducts();
  Future<Either<Failure, List<Usercart>>> fetchcartitems();
  Future addproduct(
      {required var Adults, required var tourId, required var tourDate});
  Future deleteitem({required var Id});
  Future deletewishlistitem({required var Id});

  Future<Either<Failure, List<Wishlistitem>>> fetchwishlist();
  Future addproducttowishlist({required var tourId});
  Future<Either<Failure, List<Product>>> fetchSearchResults(
      {required String name});
}
