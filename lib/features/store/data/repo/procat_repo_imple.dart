import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/store/data/cart_item/product.dart';
import 'package:graduation/features/store/data/pro_cat.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';

class ProcatRepoImple implements proCategoriesRepo {
  final ApiService apiService;

  ProcatRepoImple(this.apiService);

  @override
  Future<Either<Failure, List<ProCat>>> fetchProductCat() async {
    try {
      var data = await apiService.get(endpoint: 'tourCategories');
      print(data['data']['docs']);
      List<ProCat> categorydata = [];
      for (var item in data['data']['docs']) {
        categorydata.add(ProCat.fromJson(item));
      }
      return right(categorydata);
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Product>>> fetchProducts(
      {required String categoryId}) async {
    try {
      var data =
          await apiService.get(endpoint: 'tours?category=$categoryId');
      print(data['data']['docs']);

      List<Product> landmarkdata = [];
      for (var item in data['data']['docs']) {
        landmarkdata.add(Product.fromJson(item));
      }
      return right(landmarkdata);
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<cartProduct>>> fetchcartitems() async {
    try {
      var data = await apiService.get(
        endpoint: 'carts',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg'
          },
        ),
      );
      var productsData = data['data']['cart']['cartItems'];

      List<cartProduct> cartItems = [];
      for (var item in productsData) {
        cartItems.add(cartProduct.fromJson(item['product']));
      }

      return right(cartItems);
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<void> addproduct({required var id, required var quantity}) async {
    try {
      var data = await apiService.post(
        endpoint: 'carts',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg',
            'Content-Type': 'application/json'
          },
        ),
        body: {
          'productId': id,
          'quantity': quantity,
        },
      );
      print(data);
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.toString()}');
        throw ServerFailure.fromDiorError(e);
      } else {
        print('ServerFailure: ${e.toString()}');
        throw ServerFailure(e.toString());
      }
    }
  }

  Future<void> deleteitem({required var Id}) async {
    try {
      var data = await apiService.delete(
          endpoint: 'carts/$id',
          Headers: Options(
            headers: <String, String>{
              'Authorization':
                  'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg',
            },
          ));
      print(data);
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.toString()}');
        throw ServerFailure.fromDiorError(e);
      } else {
        print('ServerFailure: ${e.toString()}');
        throw ServerFailure(e.toString());
      }
    }
  }
}
