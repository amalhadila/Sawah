part of 'landmarks_cubit_cubit.dart';

sealed class LandmarksCubitState extends Equatable {
  const LandmarksCubitState();

  @override
  List<Object> get props => [];
}

final class LandmarksCubitInitial extends LandmarksCubitState {}

class LandmarksCubitLoading extends LandmarksCubitState {}

class LandmarksCubitFailure extends LandmarksCubitState {
  final String errMessage;

  const LandmarksCubitFailure(this.errMessage);
}

class LandmarksCubitSuccess extends LandmarksCubitState {
  final List<LandmarkOnCatModel> Landmarklist;

  const LandmarksCubitSuccess(this.Landmarklist);
}
