part of 'most_visited_cubit.dart';

sealed class MostVisitedState extends Equatable {
  const MostVisitedState();

  @override
  List<Object> get props => [];
}

final class MostVisitedInitial extends MostVisitedState {}

class MostVisitedLoading extends MostVisitedState {}

class MostVisitedFailure extends MostVisitedState {
  final String errMessage;

  const MostVisitedFailure(this.errMessage);
}

class MostVisitedSuccess extends MostVisitedState {
  final List<MostVisitedModel> MostVisitedlist;

  const MostVisitedSuccess(this.MostVisitedlist);
}
