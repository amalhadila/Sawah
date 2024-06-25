import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/features/landmarks/data/model/categories_model.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/landmarks/data/model/reviewmodel.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';

abstract class CategoriesRepo {
  Future<Either<Failure, List<CategoriesModel>>> fetchCategories();
  Future<Either<Failure, List<LandmarkOnCatModel>>> fetchlandmarks(
      {required String categoryId});
  Future<Either<Failure, List<MostVisitedModel>>> fetchmostvisited();
//  Future<Either<Failure, List<Reviewmodel>>> postreview();

}
