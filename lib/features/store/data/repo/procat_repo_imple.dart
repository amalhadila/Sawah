import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/store/data/pro_cat.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/data/productbyid/productbyid.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';
import 'package:graduation/features/store/data/usercart/usercart.dart';
import 'package:graduation/features/store/data/wishlistitem.dart';

class ProcatRepoImple implements proCategoriesRepo {
  final ApiService apiService;
  ProcatRepoImple(this.apiService);
  @override
  Future<Either<Failure, List<Product>>> fetchSearchResults(
      {required String name}) async {
    try {
      var data = await apiService.get(endpoint: 'tours', search: name);
      print(name);
      print('ssssssssssssssssssssssssssssssssssssssssssssssssss$data');
      List<Product> product = [];
      for (var match in data['data']['docs']) {
        product.add(Product.fromJson(match));
      }
      return right(product);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
   @override
Future<Either<Failure, Product>> fetchProductbyId({
  required String productId,
}) async {
  try {
    var data = await apiService.get(endpoint: 'tours/$productId');
    print(data['data']['doc']);

    Product? product;

    if (data['data']['doc'] is Map<String, dynamic>) {
      product = Product.fromJson(data['data']['doc']);
    } else if (data['data']['doc'] is Iterable) {
      for (var item in data['data']['doc']) {
        product = Product.fromJson(item);
      }
    } else {
      throw Exception('Unexpected data structure');
    }

    if (product != null) {
      return right(product);
    } else {
      throw Exception('Product not found');
    }
  } on Exception catch (e) {
    if (e is DioError) {
      return left(ServerFailure.fromDiorError(e));
    }
    return left(ServerFailure(e.toString()));
  }
}


 
  @override
  Future<Either<Failure, List<ProCat>>> fetchProductCat() async {
    try {
      var data = await apiService.get(endpoint: 'tourCategories');
     // print(data['data']['docs']);
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


  @override
  Future<Either<Failure, bool>> checkAvailability
  ({required var tourId,required var groupSize,required var tourDate}) async {
  try {
    var response = await apiService.post(endpoint:'tours/check-availability/$tourId', Headers: Options(
          headers: <String, String>{
            'Content-Type': 'application/json'
          },
        ), body: {
           "groupSize": groupSize,
          "tourDate": tourDate,
         
        },);
      

    if (response != null && response['status'] == 'success') {
      bool isAvailable = response['available'];
      return right(isAvailable);
    } else {
      return left(ServerFailure("not available"));
    }
  } on Exception catch (e) {
    if (e is DioException) {
      return left(ServerFailure.fromDiorError(e));
    }
    return left(ServerFailure(e.toString()));
  }
}
@override
  Future<Either<Failure, List<Product>>> fetchProducts(
      {required String categoryId}) async {
    try {
      var data = await apiService.get(endpoint: 'tours?category=$categoryId');
    //  print(data['data']['docs']);

      List<Product> product = [];
      for (var item in data['data']['docs']) {
        product.add(Product.fromJson(item));
      }
      return right(product);
    } on Exception catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<Product>>> fetchallProducts() async {
    try {
      var data = await apiService.get(endpoint: 'tours');
    //  print(data['data']['docs']);

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
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjMwZDllZTc2NjAwZmQwNmZjN2ViMiIsImlhdCI6MTcxNzc3Njk2NCwiZXhwIjoxNzI1NTUyOTY0fQ.GJvTEzdygj9EKYq7lIRx5ORsrlRUOPyYcs1wkQxm_OY',
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
Future<Either<Failure, List<Wishlistitem>>> fetchwishlist() async {
  try {
    var response = await apiService.get(
      endpoint: 'wishlists',
      Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjMwZDllZTc2NjAwZmQwNmZjN2ViMiIsImlhdCI6MTcxNzc3Njk2NCwiZXhwIjoxNzI1NTUyOTY0fQ.GJvTEzdygj9EKYq7lIRx5ORsrlRUOPyYcs1wkQxm_OY',
          },
        ),
    );

    if (response != null && response['data'] != null) {
      var wishlistItem = response['data'];
      
      if (wishlistItem is List) {
        List<Wishlistitem> wishlistItems = wishlistItem.map((item) {
          return Wishlistitem.fromJson(item as Map<String, dynamic>);
        }).toList();
        return right(wishlistItems);
      } else if (wishlistItem is Map<String, dynamic>) {
        Wishlistitem wishlist = Wishlistitem.fromJson(wishlistItem);
        return right([wishlist]);
      } else {
        return left(ServerFailure("Unexpected type for wishlistItem: ${wishlistItem.runtimeType}"));
      }
    } else {
      return left(ServerFailure("Unexpected response structure or null data"));
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
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjMwZDllZTc2NjAwZmQwNmZjN2ViMiIsImlhdCI6MTcxNzc3Njk2NCwiZXhwIjoxNzI1NTUyOTY0fQ.GJvTEzdygj9EKYq7lIRx5ORsrlRUOPyYcs1wkQxm_OY',
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

  Future<void>  addproducttowishlist(
      { required var tourId}) async {
    try {
      var data = await apiService.post(
        endpoint: 'wishlists',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjMwZDllZTc2NjAwZmQwNmZjN2ViMiIsImlhdCI6MTcxNzc3Njk2NCwiZXhwIjoxNzI1NTUyOTY0fQ.GJvTEzdygj9EKYq7lIRx5ORsrlRUOPyYcs1wkQxm_OY',
            'Content-Type': 'application/json'
          },
        ),
        body: {
          "tourId": tourId,
         
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
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjMwZDllZTc2NjAwZmQwNmZjN2ViMiIsImlhdCI6MTcxNzc3Njk2NCwiZXhwIjoxNzI1NTUyOTY0fQ.GJvTEzdygj9EKYq7lIRx5ORsrlRUOPyYcs1wkQxm_OY'
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

  Future<void> deletewishlistitem({required var Id}) async {
    print('Deleting item with id: $Id'); 
    try {
      var response = await apiService.delete(
        endpoint: 'wishlists/$Id',
        headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjMwZDllZTc2NjAwZmQwNmZjN2ViMiIsImlhdCI6MTcxNzc3Njk2NCwiZXhwIjoxNzI1NTUyOTY0fQ.GJvTEzdygj9EKYq7lIRx5ORsrlRUOPyYcs1wkQxm_OY'
          },
        ),
      );
      print('Response: ${response}'); 
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
