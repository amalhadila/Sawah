import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/widgets/custom_error_msg.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/deletewishlistitem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/fetchwishlist_cubit.dart';

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
          'My Wishlist',
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
      body: BlocListener<DeletewishlistitemCubit, DeletewishlistitemState>(
        listener: (context, state) {
          if (state is deletewishlistitemSuccess) {
            BlocProvider.of<FetchwishlistCubit>(context).fetchwishlist();
          }
        },
        child: BlocBuilder<FetchwishlistCubit, FetchwishlistState>(
          builder: (context, state) {
            if (state is FetchwishlistSuccess) {
              var wishlist = state.wishlist
                  ;

              if (wishlist.isNotEmpty) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: wishlist.length,
                        itemBuilder: (context, index) {
                          var item = wishlist[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13, vertical: 3),
                            child: GestureDetector(
                              onTap:() {
                                GoRouter.of(context)
                                  .push('/productinfo', extra: state.wishlist[index]);
                              },
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
                                              item.name ?? '',
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
                                               
                                              
                                              ],
                                            ),
                                            Text(
                                              '\$ ${item.price}',
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
                                            'Deleting item with id: $itemId'); 
                                        BlocProvider.of<DeletewishlistitemCubit>(context)
                                            .deletewishlistitem(Id: itemId);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: kmaincolor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
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
                      'The wishlist is empty',
                      style: TextStyle(color: kmaincolor),
                    ),
                  ),
                );
              }
            } else if (state is FetchwishlistFailure) {
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
