import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation/features/review_onlandmark/data/repo/revwrepoimp.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewstate.dart';

import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/review_onlandmark/data/repo/revwrepoimp.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewstate.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final Revwrepoimp reviewRepo;

  ReviewCubit(this.reviewRepo) : super(ReviewInitial());

  final TextEditingController commentController = TextEditingController();
  double rating = 0.0;

  void updateRating(double newRating) {
    rating = newRating;
    log('Rating updated to: $rating');
  }

  Future<void> addReviewonlandmark({
    required String landmarkid,
    required String reviewType,
    required String comment,
  }) async {
    emit(AddReviewLoading());
    log('AddReviewLoading emitted');

    try {
      final result = await reviewRepo.addReviewonlandmark(
        rating: rating,
        comment: comment,
        landmark: landmarkid,
        reviewType: reviewType,
      );

      log('API call result: $result');

      result.fold(
        (failure) {
          log('AddReviewFailure: $failure');
          emit(AddReviewFailure(failure.toString()));
        },
        (_) {
          log('AddReviewSuccess');
          emit(AddReviewSuccess());
        },
      );
    } catch (error) {
      log('Catch block error: $error');
      emit(AddReviewFailure(error.toString()));
    }
  }

  Future<void> getallReviewsonlandmark({
    required String id,
  }) async {
    emit(GetReviewLoading());

    try {
      final result = await reviewRepo.getallReviewsonlandmark(
        id: id,
      );

      result.fold(
        (failure) {
          emit(GetReviewFailure(failure.toString()));
        },
        (reviews) {
          emit(GetReviewSuccess(reviews));
        },
      );
    } catch (error) {
      emit(GetReviewFailure(error.toString()));
    }
  }



  Future<void> postReviewsontour({
    required String tourid,
    required String reviewType,
    required String comment,
  }) async {
    emit(AddReviewLoading());

    try {
      final result = await reviewRepo.postReviewsontour(
        rating: rating,
        comment: comment, // Use the parameter 'comment'
        tourid: tourid,
        reviewType: reviewType,
      );

      result.fold(
        (failure) => emit(AddReviewFailure(failure.toString())),
        (_) => emit(AddReviewSuccess()),
      );
    } catch (error) {
      emit(AddReviewFailure(error.toString()));
    }
  }

  @override
  Future<void> close() {
    commentController.dispose();
    return super.close();
  }
}
