import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/categories/data/repos/categoriesrepo_impl.dart';
import 'package:graduation/features/home/pres/manager/cubit/most_visited_cubit.dart';
import 'package:graduation/features/home/pres/views/widget/homeview_body.dart';


class Homepage extends StatelessWidget {
   Homepage({super.key});
  static String id = 'secandpage';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MostVisitedCubit(CategoriesRepoImpl(ApiService(Dio())))
            ..fetchmostvisited(),child: const homeviewbody());
  }
}