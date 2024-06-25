import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/landmarks/data/model/categories_model.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/landmarks/data/repos/categories_repo.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';

class CategoriesRepoImpl implements CategoriesRepo {
  final ApiService apiService;

  CategoriesRepoImpl(this.apiService);

  @override
  Future<Either<Failure, List<CategoriesModel>>> fetchCategories() async {
    try {
      var data = await apiService.get(endpoint: 'categories');
      List<CategoriesModel> categorydata = [];
      for (var item in data['data']['docs']) {
        categorydata.add(CategoriesModel.fromJson(item));
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
  Future<Either<Failure, List<LandmarkOnCatModel>>> fetchlandmarks(
      {required String categoryId}) async {
    try {
      var data = await apiService.get(
          endpoint: 'categories/$categoryId/landmarks?sort=rating');

      List<LandmarkOnCatModel> landmarkdata = [];
      for (var item in data['data']['docs']) {
        landmarkdata.add(LandmarkOnCatModel.fromJson(item));
      }
      return right(landmarkdata);
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MostVisitedModel>>> fetchmostvisited() async {
    try {
      var data = await apiService.get(endpoint: 'landmarks/most-visited');

      List<MostVisitedModel> mostvisiteddata = [];
      for (var item in data['data']['landmarks']) {
        mostvisiteddata.add(MostVisitedModel.fromJson(item));
      }
      return right(mostvisiteddata);
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
  Future<Either<Failure, List<MostVisitedModel>>> getreview() async {
    try {
      var data = await apiService.get(
          endpoint: 'reviews');

      List<MostVisitedModel> mostvisiteddata = [];
      for (var item in data['data']['landmarks']) {
        mostvisiteddata.add(MostVisitedModel.fromJson(item));
      }
      return right(mostvisiteddata);
    } on Exception catch (e) {
      if (e is DioError) {
        return left(ServerFailure.fromDiorError(e));
      }
      return left(ServerFailure(e.toString()));
    }
  }
}
