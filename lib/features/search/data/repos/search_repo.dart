import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/features/categories/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<LandmarkOnCatModel>>> fetchSearchResults(
      {required String name});
}
