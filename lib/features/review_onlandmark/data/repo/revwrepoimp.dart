import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/review_onlandmark/data/model/get_review_model/get_review_model.dart';
import 'package:graduation/features/review_onlandmark/data/model/get_review_model/user.dart';
import 'package:graduation/features/review_onlandmark/data/model/getreviewmodel.dart';
import 'package:graduation/features/review_onlandmark/data/model/reviewmodel.dart';
import 'package:graduation/core/errors/failures.dart';
import 'package:graduation/features/review_onlandmark/data/repo/revrepo.dart';

class Revwrepoimp implements reviews {
  final ApiService apiService;

  Revwrepoimp(this.apiService);

  @override
  Future<Either<Failure, List<ReviewModel>>> addReviewonlandmark({
    required double rating,
    required String comment,
    required String landmark,
    String reviewType = 'Landmark',
  }) async {
    try {
      var data = await apiService.post(
        endpoint: 'landmarks/$landmark/reviews',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer ${Token}',
            'Content-Type': 'application/json',
          },
        ),
        body: {
          'rating': rating,
          'comment': comment,
          'reviewType': reviewType,
        },
      );

      print(data);

        List<ReviewModel> reviewModel = (data['data']['docs'] as List)
          .map((review) => ReviewModel.fromJson(review))
          .toList();
      return Right([reviewModel.first]);
    } on Failure catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
   @override
    Future<Either<Failure, List<ReviewModel>>> postReviewsontour({
      required double rating,
      required String comment,
      required String tourid,
      String reviewType = 'Tour',
    }) async {
      try {
        var data = await apiService.post(
          endpoint: 'landmarks/$tourid/reviews',
          Headers: Options(
            headers: <String, String>{
              'Authorization':
                  'Bearer ${Token}',
              'Content-Type': 'application/json',
            },
          ),
          body: {
            'rating': rating,
            'comment': comment,
            'reviewType': reviewType,
          },
        );

        print(data);

         List<ReviewModel> reviewModel = (data['data']['docs'] as List)
          .map((review) => ReviewModel.fromJson(review))
          .toList();
        return Right([reviewModel.first]);
      } on Failure catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    }

  @override
  Future<void> deleteReview({required String id}) async {
    print('Deleting item with id: $id');
    try {
      var response = await apiService.delete(
        endpoint: 'reviews/$id',
        headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer ${Token}',
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

  @override
  Future<Either<Failure, List<GetReviewModel>>> getallReviewsonlandmark({
    required String id,
  }) async {
    log('message');

    try {
      var response = await apiService.get(
        endpoint: 'landmarks/$id/reviews',
        Headers: Options(headers: <String, String>{
          'Authorization':
              'Bearer ${Token}',
        }),
      );

      log('hhhhh');
      List<GetReviewModel> reviews = (response['data']['docs'] as List)
          .map((review) => GetReviewModel.fromJson(review))
          .toList();
      log('www');
      return right(reviews);
    } on DioError catch (e) {
    return left(ServerFailure.fromDiorError(e));
  } catch (e) {
    return left(ServerFailure(e.toString()));
  }}

// @override
// Future<Either<Failure, List<GetReviewModel>>> getallReviewsonlandmark({
//   required String id,
// }) async {
//   try {
//     print(id);
//     var response = await apiService.get(
//       endpoint: 'landmarks/$id/reviews',
//       Headers: Options(
//         headers: <String, String>{
//           'Authorization': 'Bearer ${Token}',
//         },
//       ),
//     );

//     // Add logging for response
//     print('Response: $response');

//     if (response != null) {
//       if (response['data'] != null && response['data']['docs'] != null) {
//         var cartData = response['data']['docs'];

//         // Log the data for debugging
//         print('Cart Data: $cartData');

//         // Ensure cartData is a list before processing it
//         if (cartData is List) {
//           // Convert the list of JSON objects to Getreviewmodel instances
//           List<Getreviewmodel> reviews = cartData
//               .map((data) => Getreviewmodel.fromJson(data as Map<String, dynamic>))
//               .toList();
//           return right(reviews);
//         } else {
//           return left(ServerFailure("Unexpected response structure: 'docs' is not a list"));
//         }
//       } else {
//         return left(ServerFailure("Unexpected response structure or null data"));
//       }
//     } else {
//       return left(ServerFailure("Response is null"));
//     }
//   } on Exception catch (e) {
//     if (e is DioError) {
//       return left(ServerFailure.fromDiorError(e));
//     }
//     return left(ServerFailure(e.toString()));
//   }
// }

    // @override
    // Future<Either<Failure, List<GetReviewModel>>> getallReviewsontour({
    //   required String id,
    // }) async {
    //   try {
    //     var response = await apiService.get(
    //       endpoint: 'tours/$id/reviews',
    //       Headers: Options(
    //         headers: <String, String>{
    //           'Authorization':
    //               'Bearer ${Token}',
    //         },
    //       ),
    //     );

    //     if (response != null &&
    //         response['data'] != null &&
    //         response['data']['docs'] != null) {
    //       var cartData = response['data']['docs'];
    //       Getreviewmodel getreviewmodel =
    //           Getreviewmodel.fromJson(cartData as Map<String, dynamic>);

    //       return Text('ss');
    //       // right([GetReviewModel]);
    //     } else {
    //       return left(
    //           ServerFailure("Unexpected response structure or null data"));
    //     }
    //   } on Exception catch (e) {
    //     if (e is DioError) {
    //       return left(ServerFailure.fromDiorError(e));
    //     }
    //     return left(ServerFailure(e.toString()));
    //   }
    // }

    @override
    Future<Either<Failure, List<ReviewModel>>> posttReviewsontour({
      required double rating,
      required String comment,
      required String tourid,
      String reviewType = 'Tour',
    }) async {
      try {
        var data = await apiService.post(
          endpoint: 'landmarks/$tourid/reviews',
          Headers: Options(
            headers: <String, String>{
              'Authorization':
                  'Bearer ${Token}',
              'Content-Type': 'application/json',
            },
          ),
          body: {
            'rating': rating,
            'comment': comment,
            'reviewType': reviewType,
          },
        );

        print(data);

        final reviewModel = ReviewModel.fromJson(data);
        return Right([reviewModel]);
      } on Failure catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    }

    @override
    Future<Either<Failure, List<ReviewModel>>> updateRating(
        {required String id}) {
      throw UnimplementedError();
    }

    @override
    Future<void> deletereview({required String id}) {
      // TODO: implement deletereview
      throw UnimplementedError();
    }

    @override
    Future<Either<Failure, List<ReviewModel>>> getallReviews() {
      // TODO: implement getallReviews
      throw UnimplementedError();
    }

 

    @override
    Future<Either<Failure, List<ReviewModel>>> updaterating(
        {required String id}) {
      // TODO: implement updaterating
      throw UnimplementedError();
    }

    @override
    Future<Either<Failure, List<ReviewModel>>> getReviewbyid(
        {required String id}) {
      throw UnimplementedError();
    }

    @override
    Future<Either<Failure, List<GetReviewModel>>> getallReviewsontour(
        {required String id}) {
      // TODO: implement getallReviewsontour
      throw UnimplementedError();
    }
 

  // @override
  // Future<void> deletereview({required String id}) {
  //   // TODO: implement deletereview
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, List<ReviewModel>>> getReviewbyid(
  //     {required String id}) {
  //   // TODO: implement getReviewbyid
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, List<ReviewModel>>> getallReviews() {
  //   // TODO: implement getallReviews
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, List<GetReviewModel>>> getallReviewsontour(
  //     {required String id}) {
  //   // TODO: implement getallReviewsontour
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, List<ReviewModel>>> postReviewsontour(
  //     {required double rating,
  //     required String reviewType,
  //     required String comment,
  //     required String tourid}) {
  //   // TODO: implement postReviewsontour
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<Failure, List<ReviewModel>>> updaterating(
  //     {required String id}) {
  //   // TODO: implement updaterating
  //   throw UnimplementedError();
  // }

 }