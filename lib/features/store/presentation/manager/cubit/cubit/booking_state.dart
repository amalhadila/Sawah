part of 'booking_cubit.dart';

sealed class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

final class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingFailure extends BookingState {
  final String errMessage;

  const BookingFailure(this.errMessage);
}

class BookingSuccess extends BookingState {
  final List<tour> booking_list;

  const BookingSuccess(this.booking_list);
}
