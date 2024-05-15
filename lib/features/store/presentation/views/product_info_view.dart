import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/store/data/products/products.dart';
import 'package:graduation/features/store/data/repo/procat_repo_imple.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';
import 'package:graduation/features/store/presentation/views/widgets/product_info.dart';

class ProductInfoView extends StatelessWidget {
  ProductInfoView({Key? key, required this.products});

  final Products products;
   String? id;
   int? quantity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdditemCubit(ProcatRepoImple(ApiService(Dio())))..addItemToCart(id: id, quantity: quantity),
      child: Scaffold(
        body: ProductInfo(
          products: products,
        ),
      ),
    );
  }
}

