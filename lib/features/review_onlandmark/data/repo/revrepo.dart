import 'package:dartz/dartz.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/features/review_onlandmark/data/model/getreviewmodel.dart';
import 'package:graduation/features/review_onlandmark/data/model/reviewmodel.dart';

abstract class reviews {
  Future<Either<Failure, List<ReviewModel>>> addReviewonlandmark({
    required String comment,
   required String landmark ,
    required double rating, // Added the rating parameter
    required String reviewType,
  });
  Future<Either<Failure, List<ReviewModel>>> getReviewbyid({
    required String id
  });
  Future<Either<Failure, List<ReviewModel>>> getallReviews();
  Future<Either<Failure, List<Getreviewmodel>>> getallReviewsonlandmark({  required String id, });
  Future<Either<Failure, List<Getreviewmodel>>> getallReviewsontour({  required String id, });
  Future<Either<Failure, List<ReviewModel>>> postReviewsontour({  required double rating, 
    required String reviewType,required String comment, required String tourid});
  
  Future<Either<Failure, List<ReviewModel>>> updaterating({  required String id, });
  Future<void> deletereview({  required String id, });
    
}
