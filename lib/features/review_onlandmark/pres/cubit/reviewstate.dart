import 'package:graduation/features/review_onlandmark/data/model/getreviewmodel.dart';

class ReviewState {}
class ReviewInitial extends ReviewState{}
class AddReviewSuccess extends ReviewState {}

class AddReviewFailure extends ReviewState {
  final String errorMessage;
  AddReviewFailure(this.errorMessage);
}

class AddReviewLoading extends ReviewState {}

class GetReviewSuccess extends ReviewState {
  final List<Getreviewmodel> reviews;
  GetReviewSuccess(this.reviews);
}

class GetReviewFailure extends ReviewState {
  final String errorMessage;
  GetReviewFailure(this.errorMessage);
}

class GetReviewLoading extends ReviewState {}


