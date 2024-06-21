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
      body: BlocListener<DeleteitemCubit, DeleteitemState>(
        listener: (context, state) {
          if (state is DeleteitemSuccess) {
            BlocProvider.of<GetcartitemsCubit>(context).fetchcartitems();
          }
        },
        child: BlocBuilder<GetcartitemsCubit, GetcartitemsState>(
          builder: (context, state) {
            if (state is ProductSuccess) {
              var cartItems = state.cartitems_list
                  .expand((cart) => cart.cartItems ?? [])
                  .toList();

              if (cartItems.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (context, index) {
                          var item = cartItems[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 3),
                            child: Container(
                              color: Color.fromARGB(255, 255, 248, 241),
                              height: screenHeight * .15,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 7,
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      'assets/img/landmarks/pyramids2.jpg',
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              .12,
                                      width: MediaQuery.sizeOf(context).width *
                                          .22,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.tour?.name,
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: true,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                ' Adults',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 2),
                                              Text(
                                                ' ${item.groupSize}',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            '\$ ${item.itemPrice}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      var itemId = item.id;
                                      print(
                                          'Deleting item with id: $itemId'); // Log the item ID
                                      BlocProvider.of<DeleteitemCubit>(context)
                                          .deleteitem(Id: itemId);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: kmaincolor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: screenHeight * .08,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(),
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
              } else {
                return Container(
                  height: screenHeight -
                      (screenHeight * .08) -
                      appBarHeight -
                      statusBarHeight,
                  child: const Center(
                    child: Text(
                      'Cart is Empty',
                      style: TextStyle(color: kmaincolor),
                    ),
                  ),
                );
              }
            } else if (state is ProductFailure) {
              return CustomErrorWidget(errMessage: state.errMessage);
            } else {
              return const Center(
                child: LoadingWidget(),
              );
            }
          },
        ),
      ),
    );
  }
}
