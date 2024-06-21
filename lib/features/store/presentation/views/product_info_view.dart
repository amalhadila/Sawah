import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/data/repo/procat_repo_imple.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';
import 'package:graduation/features/store/presentation/views/widgets/product_info.dart';

class ProductInfoView extends StatelessWidget {
  ProductInfoView({Key? key, required this.products});

  final Product products;
  int? Adults;
  var tourDate;
  var tourId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AdditemCubit>(
          create: (context) => AdditemCubit(ProcatRepoImple(ApiService(Dio()))),
        ),
    
      ],
      child: Scaffold(
        body: BlocBuilder<AdditemCubit, AdditemState>(
          builder: (context, state) {
            return ProductInfo(
              products: products,
            );
          },
        ),
      ),
    );
  }
}
