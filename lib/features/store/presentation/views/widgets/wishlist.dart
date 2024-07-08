import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/core/widgets/custom_error_msg.dart';
import 'package:sawah/core/widgets/loading_widget.dart';
import 'package:sawah/features/store/presentation/manager/cubit/cubit/deletewishlistitem_cubit.dart';
import 'package:sawah/features/store/presentation/manager/cubit/cubit/fetchwishlist_cubit.dart';
import 'package:sawah/features/store/presentation/manager/cubit/productbyid_cubit.dart';
import 'package:sawah/features/store/presentation/manager/cubit/productbyid_state.dart';
import 'package:shimmer/shimmer.dart';

class Wishlist extends StatelessWidget {
  Wishlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        elevation: 0,
        title: const Text(
          'My Wishlist',
          style: Textstyle.textStyle21),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ksecondcolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
              var wishlist = state.wishlist;

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
                                horizontal: 20, vertical: 13),
                            child: GestureDetector(
                              onTap: () async {
                                await BlocProvider.of<ProductbyidCubit>(context)
                                    .fetchProductbyId(productId: item.id!);
                                var productState =
                                    BlocProvider.of<ProductbyidCubit>(context)
                                        .state;
                                if (productState is productbyiduccess) {
                                  GoRouter.of(context).push(
                                    '/productinfo',
                                    extra: productState.product,
                                  );
                                } else if (productState is ProductbyFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(productState.errMessage)),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: kbackgroundcolor,
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 4,
                                        offset: Offset(0, 5),
                                        color: Color.fromARGB(64, 85, 61, 51),
                                        spreadRadius: 0,
                                        blurStyle: BlurStyle.normal)
                                  ],
                                ),
                                height: screenHeight * .17,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 7,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child:                                      
                                       CachedNetworkImage(
                                          imageUrl: item.images![0],
                                          width:
                                               MediaQuery.sizeOf(context).width *
                                                .332,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              .13,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width:  MediaQuery.sizeOf(context).width *
                                                .332,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  .13,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ), 
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 18),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name ?? '',
                                              textAlign: TextAlign.start,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                              style: Textstyle.textStyle16.copyWith(
                                color: neutralColor3,
                                )
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              'price  \$${item.price}',
                                              style: Textstyle.textStyle14.copyWith(
                                color: neutralColor3,fontWeight: FontWeight.w600
                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        var itemId = item.id;
                                        print('Deleting item with id: $itemId');
                                        BlocProvider.of<
                                                    DeletewishlistitemCubit>(
                                                context)
                                            .deletewishlistitem(Id: itemId);
                                      },
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 12.0),
                                        child: const Icon(
                                          FontAwesomeIcons.solidHeart,
                                          size: 23,
                                          color: kmaincolor,
                                        ),
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
