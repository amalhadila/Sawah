import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/core/widgets/appbar.dart';
import 'package:graduation/features/search/data/repos/search_repo_imp.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit.dart';
import 'package:graduation/features/search/presentation/views/widgets/gridsearchresult.dart';

class SearchViewBody extends StatelessWidget {
  SearchViewBody({super.key, required this.name});
  String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: BlocProvider(
          create: (context) => SearchCubit(SearchRepoImp(ApiService(Dio())))
            ..fetchSearchResult(name: name),
          child: const SearhResultGrid()),
    );
  }
}
// BlocProvider(
//       create: (context) =>
//           LandmarksCubitCubit(CategoriesRepoImpl(ApiService(Dio())))
//             ..fetchlandmarks(categoryId: categorymodel.id!),
