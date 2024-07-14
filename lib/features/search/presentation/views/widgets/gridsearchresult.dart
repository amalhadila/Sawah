import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sawah/core/widgets/loading_widget.dart';
import 'package:sawah/features/landmarks/presentation/views/widgets/customcard.dart';
import 'package:sawah/features/search/presentation/manager/searh_cubit.dart';
import 'package:sawah/features/search/presentation/manager/searh_cubit_state.dart';

class SearchResultGrid extends StatelessWidget {
  const SearchResultGrid({super.key});
class SearchResultGrid extends StatelessWidget {
  const SearchResultGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if ((state is SearchSuccess && state.landmark.isEmpty) ||
            state is SearchFailure) {
          GoRouter.of(context).push('/notfound_page_view');
        }
      },
      builder: (context, state) {
        if (state is SearchSuccess) {
          return GridView.builder(
            itemCount: state.landmark.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: (MediaQuery.of(context).size.width * .431) /
                  (MediaQuery.of(context).size.height * .253),
              crossAxisCount: 2,
              crossAxisSpacing: 22,
              mainAxisSpacing: 15,
            ),
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, x) {
              final landmark = state.landmark[x];
              final imageCover = landmark.images![0]! ??
                  'https://example.com/default_image.png'; // Provide a default image URL
              final name = landmark.name ?? 'Unknown'; // Provide a default name

              return CustomCard(
                imglink: imageCover,
                text: name,
                onTap: () =>
                    GoRouter.of(context).push('/Information', extra: landmark),
              );
            },
          );
        } else if (state is SearchLoading) {
          return const LoadingWidget();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
