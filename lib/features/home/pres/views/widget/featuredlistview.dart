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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: CustomCard(
                    img: state.MostVisitedlist[index].images![0],
                    text: state.MostVisitedlist[index].name!,
                    location:
                        state.MostVisitedlist[index].location!.governorate!,
                    onTap: () => GoRouter.of(context).push(
                        '/mostvisitedInformation',
                        extra: state.MostVisitedlist[index]),
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
