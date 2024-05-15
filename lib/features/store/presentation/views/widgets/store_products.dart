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
  int Index = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCatCubit, ProductCatState>(
      builder: (context, state) {
        if (state is ProductCatSuccess) {
          return DefaultTabController(
            length: state.pro_cat_list.length,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                bottom: TabBar(
                  indicatorWeight: 1,
                  dividerColor: kbackgroundcolor,
                  labelPadding: const EdgeInsets.only(bottom: 12,right: 25),
                    indicatorColor: kmaincolor,
                    isScrollable: true,
                    onTap: (value) {
                      setState(() {
                        Index = value;
                      });
                    },
                    tabs: state.pro_cat_list.map((cat) {
                      return Text(
                        cat.name!,
                        style:
                            Textstyle.textStyle16.copyWith(color: kmaincolor),
                      );
                    }).toList()),
              ),
              body: TabBarView(
                children: state.pro_cat_list.map((cat) {
                  return GrId(categoryId: cat.id);
                }).toList(),
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
