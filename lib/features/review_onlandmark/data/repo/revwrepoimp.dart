import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/utils/api_service.dart';
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
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg',
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
  Future<void> deleteReview({required String id}) async {
    print('Deleting item with id: $id');
    try {
      var response = await apiService.delete(
        endpoint: 'reviews/$id',
        headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg',
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
  Future<Either<Failure, List<Getreviewmodel>>> getallReviewsonlandmark({
    required String id,
  }) async {
    try {
      print(id);
      var response = await apiService.get(
        endpoint: 'landmarks/$id/reviews',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg',
          },
        ),
      );

      if (response != null &&
          response['data'] != null &&
          response['data']['docs'] != null) {
        var cartData = response['data']['docs'];
        Getreviewmodel getreviewmodel =
            Getreviewmodel.fromJson(cartData as Map<String, dynamic>);
        print(cartData);
        return right([getreviewmodel]);
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

  @override
  Future<Either<Failure, List<Getreviewmodel>>> getallReviewsontour({
    required String id,
  }) async {
    try {
      var response = await apiService.get(
        endpoint: 'tours/$id/reviews',
        Headers: Options(
          headers: <String, String>{
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg',
          },
        ),
      );

      if (response != null &&
          response['data'] != null &&
          response['data']['docs'] != null) {
        var cartData = response['data']['docs'];
        Getreviewmodel getreviewmodel =
            Getreviewmodel.fromJson(cartData as Map<String, dynamic>);

        return right([getreviewmodel]);
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
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4MTRiNTZmYTE4NCIsImlhdCI6MTcxNTU1NTA4MCwiZXhwIjoxNzIzMzMxMDgwfQ.7KcMqIu-UNoV5qBqm71cyWH8ZBzpKBMjSXq-hmgjxWg',
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
  Future<Either<Failure, List<Getreviewmodel>>> getalllReviewsonlandmark(
      {required String id}) {
    // TODO: implement getallReviewsonlandmark
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Getreviewmodel>>> getalliReviewsontour(
      {required String id}) {
    // TODO: implement getallReviewsontour
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
}
