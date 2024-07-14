import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sawah/core/widgets/custom_error_msg.dart';
import 'package:sawah/features/landmarks/presentation/manger/landmarks_cubit/landmarks_cubit_cubit.dart';
import 'package:sawah/features/landmarks/presentation/views/widgets/customcard.dart';

import '../../../../../core/widgets/loading_widget.dart';

class landmarkGrid extends StatelessWidget {
  landmarkGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandmarksCubitCubit, LandmarksCubitState>(
      builder: (context, state) {
        if (state is LandmarksCubitSuccess) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 11, right: 17, top: 20, bottom: 15),
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: state.Landmarklist.length,
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: (MediaQuery.of(context).size.width * .431) /
                      (MediaQuery.of(context).size.height * .24),
                  crossAxisCount: 2,
                  crossAxisSpacing: 22,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (context, index) {
                  return CustomCard(
                    imglink: state.Landmarklist[index].images![0]!,
                    text: state.Landmarklist[index].name!,
                    onTap: () => GoRouter.of(context)
                        .push('/Information', extra: state.Landmarklist[index]),
                  );
                },
              ),
            ),
          );
        } else if (state is LandmarksCubitFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return const Center(child: LoadingWidget());
        }
      },
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
