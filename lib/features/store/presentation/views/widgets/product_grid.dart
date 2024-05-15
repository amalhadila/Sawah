import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/widgets/custom_error_msg.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/store/presentation/manager/cubit/products_cubit.dart';
import 'package:graduation/features/store/presentation/views/widgets/card.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductSuccess) {
          print(state.product_list);
          return GridView.builder(
              itemCount: state.product_list.length,
              clipBehavior: Clip.none,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 20,
                mainAxisSpacing: 40,
              ),
              itemBuilder: (context, index) {
                return productCard(
                  imglink:
                      'assets/img/products/${state.product_list[index].images![0]}',
                  text: state.product_list[index].name!,
                  price: state.product_list[index].price!,
                  ontap: () => GoRouter.of(context)
                      .push('/productinfo', extra: state.product_list[index]),
                );
              });
        } else if (state is ProductFailure) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else {
          return const Center(
            child: LoadingWidget(),
          );
        }
      },
    );
  }
}
