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
return ListView.builder(
    itemCount: state.product_list.length,
    padding: EdgeInsets.symmetric(horizontal: 20),
shrinkWrap: true,
clipBehavior: Clip.none,

    itemBuilder: (context, index) {
    return
    Column(
  children: [
    productCard(
      imglink:
         // 'assets/img/products/${state.product_list[index].images![0]}',
         'assets/img/landmarks/pyramids2.jpg',
      text: state.product_list[index].name!,
      price: state.product_list[index].price!,
      ontap: () => GoRouter.of(context)
          .push('/productinfo', extra: state.product_list[index]),
    ),
    SizedBox(height: 1),
    Divider(
      thickness: 2.5,
      color:Color.fromARGB(255, 252, 237, 227) ,
    ),
    SizedBox(height: 1),
  ],
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

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:graduation/core/widgets/custom_error_msg.dart';
// import 'package:graduation/core/widgets/loading_widget.dart';
// import 'package:graduation/features/store/presentation/views/widgets/card.dart';

// class ProductGrid extends StatelessWidget {
//   const ProductGrid({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Sample data for testing purposes
//     final List<Map<String, dynamic>> sampleProducts = [
//       {
//         'images': ['product1.jpg'],
//         'name': 'Product 1',
//         'info': 'infoooo',
//         'price': '10'
//       },
//       {
//         'images': ['product2.jpg'],
//         'name': 'Product 2',
//         'info': 'infoooo',
//         'price': '20'
//       },
//       {
//         'images': ['product3.jpg'],
//         'name': 'Product 3',
//         'info': 'infoooo',
//         'price': '30'
//       },
//       {
//         'images': ['product4.jpg'],
//         'name': 'Product 4',
//         'info': 'infoooo',
//         'price': '40'
//       }
//     ];

//     return
//         // BlocBuilder<ProductsCubit, ProductsState>(
//         // builder: (context, state) {
//         //   if (state is ProductSuccess) {
//         //     print(state.product_list);
//         //     return
//         ListView.builder(
//             itemCount: sampleProducts.length,
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             shrinkWrap: true,
//             clipBehavior: Clip.none,
//             itemBuilder: (context, index) {
//               return Column(
//                 children: [
//                   productCard(
//                     imglink:
//                         'assets/img/products/${sampleProducts[index]['images'][0]}',
//                     text: sampleProducts[index]['name'],
//                     info: sampleProducts[index]['info'],
//                     price: sampleProducts[index]['price'],
//                     ontap: () => GoRouter.of(context).push('/productinfoo'),
//                   ),
//                   const SizedBox(height: .5),
//                   const Divider(
//                     thickness: 2.5,
//                     color: Color.fromARGB(255, 252, 237, 227),
//                   ),
//                   const SizedBox(height: .5),
//                 ],
//               );
//             });
//     //   } else if (state is ProductFailure) {
//     //     return CustomErrorWidget(errMessage: state.errMessage);
//     //   } else {
//     //     return const Center(
//     //       child: LoadingWidget(),
//     //     );
//     //   }
//     // },
//     // );
//   }
// }
