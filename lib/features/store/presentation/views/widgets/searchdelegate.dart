import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/core/widgets/loading_widget.dart';
import 'package:sawah/features/store/presentation/manager/cubit/searchproduct_cubit.dart';
import 'package:sawah/features/store/presentation/manager/cubit/searchproduct_state.dart';
import 'package:shimmer/shimmer.dart';

class ProductSearchWidget extends StatefulWidget {
  @override
  _ProductSearchWidgetState createState() => _ProductSearchWidgetState();
}

class _ProductSearchWidgetState extends State<ProductSearchWidget> {
  String? query;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: kmaincolor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search for tour...',
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              query = value;
            });
            BlocProvider.of<SearchproductCubit>(context)
                .fetchSearchResult(name: query!);
          },
        ),
      ),
      body: BlocBuilder<SearchproductCubit, SearchproductStates>(
        builder: (context, state) {
          if (state is SearchproductSuccess) {
            final products = state.product;
            if (products.isEmpty) {
              return const Center(
                  child: Text(
                'No results found.',
              ));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context)
                        .push('/productinfo', extra: state.product[index]);
                  },
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 7,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: 
                              CachedNetworkImage(
                                          imageUrl: product.images[0],
                                          width:
                                               MediaQuery.sizeOf(context).width * .2,
                                          height: MediaQuery.sizeOf(context).height * .1,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.grey[100]!,
                                            child: Container(
                                              width:  MediaQuery.sizeOf(context).width * .2,
                                              height: MediaQuery.sizeOf(context).height * .1,
                                              color: Colors.white,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name ?? '',
                                      textAlign: TextAlign.start,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style:Textstyle.textStyle15.copyWith(
                                color: neutralColor3,
                                 fontWeight: FontWeight.w700,
                                )
                                    ),
                                    Column(children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: accentColor1,
                                            size: 18,
                                          ),
                                          Text(
                                            product.location!.address!,
                                            style:Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                 fontWeight: FontWeight.w600,
                                )
                                          ),
                                        ],
                                      ),
                                     
                                    ]),
                                    Text(
                                      'price  \$${product.price}',
                                      style: Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                 fontWeight: FontWeight.w600,
                                )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: neutralColor),
                    ],
                  ),
                );
              },
            );
          } else if (state is SearchproductFailure) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
