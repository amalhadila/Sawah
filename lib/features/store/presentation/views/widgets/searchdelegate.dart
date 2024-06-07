// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation/core/widgets/loading_widget.dart';
// import 'package:graduation/features/store/presentation/manager/cubit/searchproduct_cubit.dart';
// import 'package:graduation/features/store/presentation/manager/cubit/searchproduct_state.dart';

// class ProductSearchWidget extends StatefulWidget {
//   @override
//   _ProductSearchWidgetState createState() => _ProductSearchWidgetState();
// }

// class _ProductSearchWidgetState extends State<ProductSearchWidget> {
//   String query = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         title: TextField(
//           decoration: InputDecoration(
//             hintText: 'Search for products...',
//             border: InputBorder.none,
//           ),
//           onChanged: (value) {
//             setState(() {
//               query = value;
//             });
//             BlocProvider.of<SearchproductCubit>(context).fetchSearchResult(name: 'dahab');
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.clear, color: Colors.black),
//             onPressed: () {
//               setState(() {
//                 query = '';
//               });
//             },
//           ),
//         ],
//       ),
//       body: BlocBuilder<SearchproductCubit, SearchproductStates>(
//         builder: (context, state) {
//           if (state is SearchproductSuccess) {
//             final products = state.product;
//             if (products.isEmpty) {
//               return Center(child: Text('No results found.'));
//             }
//             return ListView.builder(
//               itemCount: products.length,
//               itemBuilder: (context, index) {
//                 final product = products[index];
//                 return ListTile(
//                   title: Text(product.name ?? ''),
//                   subtitle: Text(product.description ?? ''),
//                   onTap: () {
//                     // Handle product tap
//                   },
//                 );
//               },
//             );
//           } else if (state is SearchproductFailure) {
//             return Center(child: Text('Error: ${state.errorMessage}'));
//           } else {
//             return const LoadingWidget();
//           }
//         },
//       ),
//     );
//   }
// }
