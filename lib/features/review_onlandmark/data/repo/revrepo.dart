import 'package:dartz/dartz.dart';
import 'package:sawah/core/errors/failures.dart';
import 'package:sawah/features/review_onlandmark/data/model/get_review_model/get_review_model.dart';
import 'package:sawah/features/review_onlandmark/data/model/getreviewmodel.dart';
import 'package:sawah/features/review_onlandmark/data/model/reviewmodel.dart';

abstract class reviews {
  Future<Either<Failure, List<ReviewModel>>> addReviewonlandmark({
    required String comment,
    required String landmark,
    required double rating, // Added the rating parameter
    required String reviewType,
  });
  Future<Either<Failure, List<ReviewModel>>> getReviewbyid(
      {required String id});
  Future<Either<Failure, List<ReviewModel>>> getallReviews();
  Future<Either<Failure, List<GetReviewModel>>> getallReviewsonlandmark({
    required String id,
  });
  Future<Either<Failure, List<GetReviewModel>>> getallReviewsontour({
    required String id,
  });
  Future<Either<Failure, List<ReviewModel>>> postReviewsontour(
      {required double rating,
      required String reviewType,
      required String comment,
      required String tourid});

  Future<Either<Failure, List<ReviewModel>>> updaterating({
    required String id,
  });
  Future<void> deletereview({
    required String id,
  });
}
