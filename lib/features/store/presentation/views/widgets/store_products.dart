import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/store/presentation/manager/cubit/product_cat_cubit.dart';
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
    return BlocBuilder<ProductCatCubit, ProductCatState>(
      builder: (context, state) {
        if (state is ProductCatSuccess) {
          return DefaultTabController(
            length: state.pro_cat_list.length + 1,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  bottom: TabBar(
                    indicator: BoxDecoration(
                      color:
                     kmaincolor,
                     //  Color.fromARGB(255, 247, 227, 227),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: kbackgroundcolor,
                    labelPadding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
                    isScrollable: true,
                    onTap: (value) {
                      setState(() {
                        index = value;
                      });
                    },
                    tabs: [
                      Text(
                        ' All ',
                         style:
                             Textstyle.textStyle15,
                      ),
                      ...state.pro_cat_list.map((cat) {
                        return Text(
                          cat.name!,
                           style:
                               Textstyle.textStyle15,
                        );
                      }).toList(),
                    ],
                   labelColor: kbackgroundcolor, // لون النص عندما يكون التبويب محدد
                   unselectedLabelColor: kmaincolor,
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  GrId(),
                  ...state.pro_cat_list.map((cat) {
                    return GrId(categoryId: cat.id);
                  }).toList(),
                ],
              ),
            ),
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }
}
