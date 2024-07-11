import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/core/widgets/loading_widget.dart';
import 'package:sawah/features/store/presentation/manager/cubit/product_cat_cubit.dart';
import 'package:sawah/features/store/presentation/views/widgets/listview.dart';

class store_product extends StatefulWidget {
  const store_product({Key? key}) : super(key: key);

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
                  backgroundColor: kbackgroundcolor,
                  elevation: 0,
                  bottom: TabBar(
                    indicator: BoxDecoration(
                      color: kmaincolor,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          'All',
                          style: Textstyle.textStyle15,
                        ),
                      ),
                      ...state.pro_cat_list.map((cat) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Text(
                            cat.name!,
                            style: Textstyle.textStyle15,
                          ),
                        );
                      }).toList(),
                    ],
                    labelColor: kbackgroundcolor,
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
