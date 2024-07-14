import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sawah/features/landmarks/presentation/views/widgets/landmark_grid.dart';

import 'package:sawah/features/store/data/repo/pro_cat_repo.dart';
import 'package:sawah/features/store/data/usercart/tour.dart';

import '../../../../data/booking/booking/tour.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit(this.catrepo) : super(BookingInitial());
  final proCategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<void> fetchBookings() async {
    if (_closed) return;
    print('loading');
    emit(BookingLoading());

    var result = await catrepo
        .fetchBookings(); // Call the fetchBookings function from your repository
    result.fold((failure) {
      if (!_closed) emit(BookingFailure(failure.message));
    }, (tourList) {
      print('aaaaaaaaaaaaaaaaaaaaaaaaaa');
      print(tourList);
      if (!_closed) emit(BookingSuccess(tourList));
    });
  }
}