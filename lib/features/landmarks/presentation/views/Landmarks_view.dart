import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/landmarks/data/model/categories_model.dart';
import 'package:graduation/features/landmarks/data/repos/categoriesrepo_impl.dart';
import 'package:graduation/features/landmarks/presentation/manger/landmarks_cubit/landmarks_cubit_cubit.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/Landmarks_view_Body.dart';

class Landmarks_view extends StatelessWidget {
  const Landmarks_view({super.key, required this.categorymodel});
  final CategoriesModel categorymodel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) =>
          LandmarksCubitCubit(CategoriesRepoImpl(ApiService(Dio())))
            ..fetchlandmarks(categoryId: categorymodel.id!),
      child: LandmarksBody(),
    ));
  }
}
