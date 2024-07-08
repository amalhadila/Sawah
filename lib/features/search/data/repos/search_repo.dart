import 'package:dartz/dartz.dart';
import 'package:sawah/core/errors/failures.dart';
import 'package:sawah/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, List<LandmarkOnCatModel>>> fetchSearchResults(
      {required String name});
}
