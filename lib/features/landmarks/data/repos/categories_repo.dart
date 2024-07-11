import 'package:dartz/dartz.dart';
import 'package:sawah/core/errors/failures.dart';
import 'package:sawah/features/landmarks/data/model/categories_model.dart';
import 'package:sawah/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:sawah/features/home/data/models/most_visited_model/most_visited_model.dart';
import 'package:sawah/features/store/data/product/product.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<Product>>> recommendation({String? landmarkId});

  Future<Either<Failure, List<CategoriesModel>>> fetchCategories();
  Future<Either<Failure, List<LandmarkOnCatModel>>> fetchlandmarks(
      {required String categoryId});
  Future<Either<Failure, List<MostVisitedModel>>> fetchmostvisited();
//  Future<Either<Failure, List<Reviewmodel>>> postreview();
}
