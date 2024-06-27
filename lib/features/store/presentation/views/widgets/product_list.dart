import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/widgets/custom_error_msg.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/allproducts_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/products_cubit.dart';
import 'package:graduation/features/store/presentation/views/widgets/card.dart';

class ProductGrid extends StatelessWidget {
  final String? categoryId;

  const ProductGrid({super.key, this.categoryId});

  @override
  Widget build(BuildContext context) {
    if (categoryId != null) {
      return BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            return buildProductList(state.product_list);
          } else if (state is ProductFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else {
            return const Center(child: LoadingWidget());
          }
        },
      );
    } else {
      return BlocBuilder<AllproductsCubit, AllproductsState>(
        builder: (context, state) {
          if (state is AllproductSuccess) {
            return buildProductList(state.product_list);
          } else if (state is AllproductFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else {
            return const Center(child: LoadingWidget());
          }
        },
      );
    }
  }

  Widget buildProductList(List<Product> productList) {
    return ListView.builder(
      itemCount: productList.length,
      padding: EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        final product = productList[index];
        return Column(
          children: [
            productCard(
              address1:productList[index].locations,
              id: productList[index].id!,
              imglink: productList[index].images[0],
              info: product.description,
              rating: product.rating != null ? product.rating!.round() : null, 
              text: product.name ?? 'Unknown Product',
              price: product.price ?? 0, // Default value if price is null
              ontap: () => GoRouter.of(context).push('/productinfo', extra: product),
            ),
            SizedBox(height: 14),
           
          ],
        );
      },
    );
  }
}
