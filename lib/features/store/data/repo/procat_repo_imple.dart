import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/store/data/pro_cat.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';
import 'package:graduation/features/store/data/usercart/usercart.dart';

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
      var data = await apiService.get(endpoint: 'tours/$categoryId');
      print(data['data']['doc']);

      List<Product> product = [];
      for (var item in data['data']['doc']) {
        product.add(Product.fromJson(item));
      }
      return right(product);
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Product>>> fetchallProducts() async {
    try {
      var data = await apiService.get(endpoint: 'tours');
      print(data['data']['docs']);

      List<Product> product = [];
      for (var item in data['data']['docs']) {
        product.add(Product.fromJson(item));
      }
      return right(product);
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Usercart>>> fetchcartitems() async {
    try {
      var response = await apiService.get(
        endpoint: 'carts',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjRlMmY4ZmI4MTRiNTZmYTE4NSIsImlhdCI6MTcxNzQ0NjY0NiwiZXhwIjoxNzI1MjIyNjQ2fQ.dU5JzycZetFhZ6GvxTeM2ke5XIWmveZ1bAqFFIwhYss'
          },
        ),
      );

      if (response != null &&
          response['data'] != null &&
          response['data']['cart'] != null) {
        var cartData = response['data']['cart'];
        Usercart userCart = Usercart.fromJson(cartData as Map<String, dynamic>);

        return right([userCart]);
      } else {
        return left(
            ServerFailure("Unexpected response structure or null data"));
      }
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<void> addproduct(
      {required var Adults, required var tourId, required var tourDate}) async {
    try {
      var data = await apiService.post(
        endpoint: 'carts',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjRlMmY4ZmI4MTRiNTZmYTE4NSIsImlhdCI6MTcxNzQ5ODI3NywiZXhwIjoxNzI1Mjc0Mjc3fQ.EEAvZiAkAcH9G9HDQC17xi_Io35MD0gzFTfssKEqcVU',
            'Content-Type': 'application/json'
          },
        ),
        body: {
          "tourId": tourId,
          "tourDate": tourDate,
          "groupSize": Adults,
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
    print('Deleting item with id: $Id'); // Log the ID
    try {
      var response = await apiService.delete(
        endpoint: 'carts/$Id',
        headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjRlMmY4ZmI4MTRiNTZmYTE4NSIsImlhdCI6MTcxNzQ5ODI3NywiZXhwIjoxNzI1Mjc0Mjc3fQ.EEAvZiAkAcH9G9HDQC17xi_Io35MD0gzFTfssKEqcVU'
          },
        ),
      );
      print('Response: ${response}'); // Log the response
    } catch (e) {
      if (e is DioError) {
        print('DioError: ${e.toString()}');
        print('Response data: ${e.response?.data}');
        throw ServerFailure.fromDiorError(e);
      } else {
        print('ServerFailure: ${e.toString()}');
        throw ServerFailure(e.toString());
      }
    }
  }
}
