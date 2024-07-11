import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/core/utils/api_service.dart';
import 'package:sawah/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:sawah/features/landmarks/data/repos/categoriesrepo_impl.dart';
import 'package:sawah/features/landmarks/presentation/manger/cubit/recommendation_cubit.dart';
import 'package:sawah/features/landmarks/presentation/manger/more_info_cubit/more_info_cubit.dart';
import 'package:sawah/features/landmarks/presentation/views/widgets/info_view_body.dart';
import 'package:sawah/features/home/data/models/most_visited_model/most_visited_model.dart';

class Infoview extends StatelessWidget {
  const Infoview({super.key, this.landmaroncatkmodel, this.mostVisitedModel});
  final LandmarkOnCatModel? landmaroncatkmodel;
  final MostVisitedModel? mostVisitedModel;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoreInfoCubit(),
        ),
        BlocProvider(
          create: (context) =>
              RecommendationCubit(CategoriesRepoImpl(ApiService(Dio())))
                ..recommendation(
                    landmarkId:
                        (landmaroncatkmodel?.id ?? mostVisitedModel?.id)!),
        ),
      ],
      child: Scaffold(
        body: InfViewBody(
          landmarkoncatModel: landmaroncatkmodel,
          mostVisitedModel: mostVisitedModel,
        ),
      ),
    );
  }
}
