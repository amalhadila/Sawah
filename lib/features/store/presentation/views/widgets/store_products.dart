// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation/constants.dart';
// import 'package:graduation/core/utils/style.dart';
// import 'package:graduation/core/widgets/loading_widget.dart';
// import 'package:graduation/features/store/presentation/manager/cubit/product_cat_cubit.dart';
// import 'package:graduation/features/store/presentation/views/widgets/gr_id.dart';

// class store_product extends StatefulWidget {
//   store_product({Key? key}) : super(key: key);

//   @override
//   State<store_product> createState() => _store_productState();
// }

// class _store_productState extends State<store_product> {
//   int Index = 0;

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ProductCatCubit, ProductCatState>(
//       builder: (context, state) {
//         if (state is ProductCatSuccess) {
//           return DefaultTabController(
//             length: state.pro_cat_list.length,
//             child: Scaffold(
//               appBar: PreferredSize(
//                 preferredSize: Size.fromHeight(50),
//                 child: AppBar(
//                   backgroundColor: Colors.white,
//                   elevation: 0,
//                   bottom: TabBar(
//                     indicator: BoxDecoration(
//                   color:  Color.fromARGB(255, 247, 227, 227),
//                   borderRadius: BorderRadius.circular(10)
//                 ),
//                 indicatorSize: TabBarIndicatorSize.tab,
//                 dividerColor: kbackgroundcolor,
//                 labelPadding: const EdgeInsets.symmetric(horizontal:9, vertical: 7),
//                 isScrollable: true,
//                       onTap: (value) {
//                         setState(() {
//                           Index = value;
//                         });
//                       },
//                       tabs: state.pro_cat_list.map((cat) {
//                         return Text(
//                           cat.name!,
//                           style:
//                               Textstyle.textStyle15.copyWith(color: kmaincolor),
//                         );
//                       }).toList()),
//                 ),
//               ),
//               body: TabBarView(
//                 children: state.pro_cat_list.map((cat) {
//                   return GrId(categoryId: cat.id);
//                 }).toList(),
//               ),
//             ),
//           );
//         } else {
//           return const LoadingWidget();
//         }
//       },
//     );
//   }
// }

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/store/presentation/views/widgets/gr_id.dart';

class store_product extends StatefulWidget {
  store_product({Key? key}) : super(key: key);

  @override
  State<store_product> createState() => _store_productState();
}

class _store_productState extends State<store_product> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    // Sample categories for testing purposes
    final List<Map<String, dynamic>> sampleCategories = [
      {'id': 1, 'name': 'Category 1'},
      {'id': 2, 'name': 'Category 2'},
      {'id': 3, 'name': 'Category 3'},
      {'id': 4, 'name': 'Category 4'},
    ];

    return
      // BlocBuilder<ProductCatCubit, ProductCatState>(
      // builder: (context, state) {
      //   if (state is ProductCatSuccess) {
      //     return
      DefaultTabController(
        length: sampleCategories.length,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: TabBar(
                padding: EdgeInsets.symmetric(vertical: 5),
                indicator: BoxDecoration(
                  color: Color.fromARGB(255, 252, 237, 227),
                  borderRadius: BorderRadius.circular(12)
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: kbackgroundcolor,
                labelPadding: const EdgeInsets.symmetric(horizontal:9, vertical: 7),
                isScrollable: true,
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                tabs: sampleCategories.map((cat) {
                  return Container(
                    
                    child: Text(
                      cat['name'],
                      style: Textstyle.textStyle15.copyWith(color: kmaincolor),
                    ),
                  );
                }).toList(),
                
              ),
            ),
          ),
          body: TabBarView(
            
            children: sampleCategories.map((cat) {
              return GrId();
            }).toList(),
          ),
        ),
      );
      //   } else {
      //     return const LoadingWidget();
      //   }
      // },
    // );
  }
}

