import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/widgets/custom_error_msg.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/deleteitem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/getcartitems_cubit.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: BlocBuilder<GetcartitemsCubit, GetcartitemsState>(
        builder: (context, state) {
          if (state is ProductSuccess) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      if (state.cartitems_list.isNotEmpty) {
                        return Container(
                          height: screenHeight -
                              statusBarHeight -
                              appBarHeight -
                              (screenHeight * .08),
                          child: ListView.builder(
                            itemCount: state.cartitems_list.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(15),
                                child: GestureDetector(
                                  onTapUp: (details) {},
                                  child: Container(
                                    height: screenHeight * .15,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: screenHeight * .085 / 2,
                                          backgroundImage: const AssetImage(
                                              'assets/img/apple-watch-series-8-2.jpg'),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.cartitems_list[index].name!,
                                                  textAlign: TextAlign.center,
                                                  maxLines: 3,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  '\$ ${state.cartitems_list[index].price!}',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Quantity',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              state.cartitems_list[index].quantity.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                BlocProvider.of<DeleteitemCubit>(context).deleteitem(
                                                  id: state.cartitems_list[index].id,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: kmaincolor,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container(
                          height: screenHeight -
                              (screenHeight * .08) -
                              appBarHeight -
                              statusBarHeight,
                          child: const Center(
                            child: Text('Cart is Empty'),
                          ),
                        );
                      }
                    },
                  ),
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: screenHeight * .08,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                   //   primary: kmaincolor,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Check Out',
                      style: TextStyle(
                        color: kbackgroundcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is ProductFailure) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else {
            return const Center(
              child: LoadingWidget(),
            );
          }
        },
      ),
    );
  }
}
