part of 'recommendation_cubit.dart';

sealed class RecommendationState extends Equatable {
  const RecommendationState();

  @override
  List<Object> get props => [];
}

final class RecommendationInitial extends RecommendationState {}

class RecommendationLoading extends RecommendationState {}

class RecommendationFailure extends RecommendationState {
  final String errMessage;

  const RecommendationFailure(this.errMessage);
}

class RecommendationSuccess extends RecommendationState {
  final List<Product> product_list;

  const RecommendationSuccess(this.product_list);
}
