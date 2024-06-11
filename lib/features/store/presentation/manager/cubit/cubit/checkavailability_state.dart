part of 'checkavailability_cubit.dart';

sealed class CheckavailabilityState extends Equatable {
  const CheckavailabilityState();

  @override
  List<Object> get props => [];
}

final class CheckavailabilityInitial extends CheckavailabilityState {}

class CheckavailabilityLoading extends CheckavailabilityState {}

class CheckavailabilityFailure extends CheckavailabilityState {
  final String errMessage;

  const CheckavailabilityFailure(this.errMessage);
}

class CheckavailabilitySuccess extends CheckavailabilityState {
  final bool wishlist;

  const CheckavailabilitySuccess(this.wishlist);
}
