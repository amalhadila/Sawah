import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/categories/data/repos/categoriesrepo_impl.dart';
import 'package:graduation/features/categories/presentation/manger/categories_cubit/categories_cubit_cubit.dart';
import 'package:graduation/features/categories/presentation/views/widgets/categories_view_body.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            CategoriesCubitCubit(CategoriesRepoImpl(ApiService(Dio())))
              ..fetchCategories(),
      )
    ], child: CategoriesViewBody()));
  }
}
