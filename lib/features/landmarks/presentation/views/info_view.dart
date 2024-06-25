import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/landmarks/presentation/manger/more_info_cubit/more_info_cubit.dart';
import 'package:graduation/features/landmarks/presentation/views/widgets/info_view_body.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';

class Infoview extends StatelessWidget {
  const Infoview({super.key, this.landmaroncatkmodel, this.mostVisitedModel});
  final LandmarkOnCatModel? landmaroncatkmodel;
  final MostVisitedModel? mostVisitedModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreInfoCubit(),
      child: Scaffold(
        body: InfViewBody(
          landmarkoncatModel: landmaroncatkmodel,
          mostVisitedModel: mostVisitedModel,
        ),
      ),
    );
  }
}
