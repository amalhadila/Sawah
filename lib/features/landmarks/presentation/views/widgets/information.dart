import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/features/home/data/models/most_visited_model/most_visited_model.dart';
import 'package:sawah/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:sawah/features/landmarks/presentation/manger/cubit/recommendation_cubit.dart';
import 'package:sawah/features/review_onlandmark/pres/comment.dart';
import 'package:shimmer/shimmer.dart';

class Information extends StatefulWidget {
  const Information({
    Key? key,
    required this.text,
    this.landmarkmodel,
    this.mostvistedkmodel,
  }) : super(key: key);

  final String text;
  final LandmarkOnCatModel? landmarkmodel;
  final MostVisitedModel? mostvistedkmodel;

  @override
  _InformationState createState() => _InformationState();
}

class _InformationState extends State<Information>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: TabBar(
            controller: _tabController,
            indicatorWeight: 1,
            dividerColor: kbackgroundcolor,
            indicatorColor: kmaincolor,
            isScrollable: true,
            onTap: (value) {
              setState(() {});
            },
            tabs: [
              Tab(
                child: Text(
                  '     Information    ',
                  style: TextStyle(color: kmaincolor),
                ),
              ),
              Tab(
                child: Text(
                  '     Reviews    ',
                  style: TextStyle(color: kmaincolor),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 400, // Set a fixed height for the TabBarView
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.text,
                        style: Textstyle.textStyle13.copyWith(
                          color: neutralColor3,
                          fontWeight: FontWeight.w500,
                          height: 1.7,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Recommended tours',
                        style: Textstyle.textStyle18
                            .copyWith(color: neutralColor3, height: 1.7),
                      ),
                      BlocBuilder<RecommendationCubit, RecommendationState>(
                        builder: (context, state) {
                          if (state is RecommendationLoading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is RecommendationSuccess) {
                            final productList = state.product_list;
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.22,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                    color: shadow,
                                    spreadRadius: 0,
                                    blurStyle: BlurStyle.normal,
                                  ),
                                ],
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: productList.length,
                                itemBuilder: (context, index) {
                                  final product = productList[index];
                                  return GestureDetector(
                                    onTap: () => GoRouter.of(context)
                                        .push('/productinfo', extra: product),
                                    child: Card(
                                      color: secondaryColor1,
                                      elevation: 0,
                                      child: Container(
                                        width: 185,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.11,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: CachedNetworkImage(
                                                    imageUrl: product
                                                            .images.isNotEmpty
                                                        ? product.images[0]
                                                        : '',
                                                    width: double.infinity,
                                                    fit: BoxFit.fill,
                                                    placeholder:
                                                        (context, url) =>
                                                            Shimmer.fromColors(
                                                      baseColor:
                                                          Colors.grey[300]!,
                                                      highlightColor:
                                                          Colors.grey[100]!,
                                                      child: Container(
                                                        width: double.infinity,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                product.name ?? '',
                                                style: Textstyle.textStyle13
                                                    .copyWith(
                                                        color: neutralColor3),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Icon(Icons.star,
                                                        color: Colors.yellow),
                                                    Text(
                                                      product.rating
                                                              ?.toString() ??
                                                          '',
                                                      style: TextStyle(
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else if (state is RecommendationFailure) {
                            return Center(
                              child: Text(
                                'Failed to load products: ${state.errMessage}',
                              ),
                            );
                          } else {
                            return Container(); // Handle default state
                          }
                        },
                      ),
                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
              ReviewPage(
                landmarkmodel: widget.landmarkmodel,
                mostvistedkmodel: widget.mostvistedkmodel,
              ), // Pass the actual landmark model instance
            ],
          ),
        ),
      ],
    );
  }
}
