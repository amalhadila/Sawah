part of 'categories_cubit_cubit.dart';

sealed class CategoriesCubitState extends Equatable {
  const CategoriesCubitState();

  @override
  List<Object> get props => [];
}

class CategoriesCubitInitial extends CategoriesCubitState {}

class CategoriesCubitLoading extends CategoriesCubitState {}

class CategoriesCubitFailure extends CategoriesCubitState {
  final String errMessage;

  const CategoriesCubitFailure(this.errMessage);
}

class CategoriesCubitSuccess extends CategoriesCubitState {
  final List<CategoriesModel> categorieslist;

  const CategoriesCubitSuccess(this.categorieslist);
}
