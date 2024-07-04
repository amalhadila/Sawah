import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/store/data/repo/procat_repo_imple.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/allproducts_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/products_cubit.dart';
import 'package:graduation/features/store/presentation/views/widgets/product_list.dart';

class GrId extends StatelessWidget {
  GrId({super.key, this.categoryId});
  String? categoryId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        if (categoryId != null)
          BlocProvider<ProductsCubit>(
            create: (context) =>
                ProductsCubit(ProcatRepoImple(ApiService(Dio())))
                  ..fetchProducts(categoryId: categoryId!),
          ),
        if (categoryId == null)
          BlocProvider<AllproductsCubit>(
            create: (context) =>
                AllproductsCubit(ProcatRepoImple(ApiService(Dio())))
                  ..fetchallProducts(),
          ),
      ],
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
          child: ProductGrid(categoryId: categoryId),
        ),
      ),
    );
  }
}
