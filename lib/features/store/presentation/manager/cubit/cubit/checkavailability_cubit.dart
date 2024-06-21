import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graduation/auth/core_login/errors/excpetion.dart';
import 'package:graduation/features/store/data/repo/pro_cat_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

part 'checkavailability_state.dart';

class CheckavailabilityCubit extends Cubit<CheckavailabilityState> {
  CheckavailabilityCubit(this.catrepo) : super(CheckavailabilityInitial());
  final proCategoriesRepo catrepo;
  bool _closed = false;

  @override
  Future<void> close() async {
    _closed = true;
    return super.close();
  }

  Future<bool> checkAvailability({
    required var Id,
    required var groupSize,
    required var tourDate,
  }) async {
    if (_closed) return false; // Ensure a return value if closed
    emit(CheckavailabilityLoading());

    try {
      var result = await catrepo.checkAvailability(
        tourId: Id,
        groupSize: groupSize,
        tourDate: tourDate,
      );

      bool isAvailable = false;

      result.fold(
        (failure) {
          if (!_closed) {
            emit(CheckavailabilityFailure(failure.message));
          }
          print('Failure: ${failure.message}');
        },
        (available) {
          isAvailable = available;
          if (!_closed) {
            emit(CheckavailabilitySuccess(available));
          }
          print('Available: $available');
        },
      );

      print('isAvailable: $isAvailable');
      return isAvailable;

    } on DioError catch (e) {
      final failure = ServerFailure.fromDioError(e);
      if (!_closed) {
        emit(CheckavailabilityFailure(failure.errorMessage));
      }
      print('Failure: ${failure.errorMessage}');
      return false;
    } catch (e) {
      if (!_closed) {
        emit(CheckavailabilityFailure('Unexpected error occurred'));
      }
      print('Unexpected error: $e');
      return false;
    }
  }
}
