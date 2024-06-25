import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/widgets/custom_error_msg.dart';
import 'package:graduation/features/home/pres/manager/cubit/most_visited_cubit.dart';
import 'package:graduation/features/home/pres/views/widget/modelforplace.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/loading_widget.dart';

class feturedcustemlist extends StatelessWidget {
  const feturedcustemlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MostVisitedCubit, MostVisitedState>(
      builder: (context, state) {
        if (state is MostVisitedSuccess) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .25,
            child: ListView.builder(
              itemCount: state.MostVisitedlist.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = state.MostVisitedlist[index];
                final img = item.imageCover ?? 'assets/PYRAMIDS.webp'; // Default image if null
                final text = item.name ?? 'Unknown Place'; // Default text if null
                final location = item.location?.governorate ?? 'Unknown Location'; // Default location if null

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CustomCard(
                    img: img,
                    text: text,
                    location: location,
                    onTap: () => GoRouter.of(context).push(
                      '/mostvisitedInformation',
                      extra: item,
                    ),
                  ),
                );
              },
            ),
          );
        } else if (state is MostVisitedFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return const Center(child: LoadingWidget());
        }
      },
    );
  }
}
