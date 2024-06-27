//part of 'search_cubit.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';

sealed class SearchStates {
  const SearchStates();
}

final class SearchResultInitialState extends SearchStates {}

class SearchLoading extends SearchStates {}

class SearchSuccess extends SearchStates {
  final List<LandmarkOnCatModel> landmark;

  const SearchSuccess(this.landmark);
}

class SearchFailure extends SearchStates {
  final String errorMessage;

  const SearchFailure(this.errorMessage);
}
