import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/review_onlandmark/pres/commentfortour.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/getcartitems_cubit.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';

class ProductInfo extends StatefulWidget {
  final Product products;
  String? token;

  ProductInfo({Key? key, required this.products}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * .40,
            flexibleSpace: FlexibleSpaceBar(
              background:
                  //  Image.asset(
                  //   'assets/img/landmarks/pyramids2.jpg',
                  //   fit: BoxFit.fill,
                  // ),
                  SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .31,
                child: CarouselSlider(
                  disableGesture: false,
                  items: widget.products.images.map((image) {
                    return 
                         CachedNetworkImage(
      imageUrl: image,
      width: double.infinity,
      fit: BoxFit.fill,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: double.infinity,
          color: Colors.white,
        ),
      ),errorWidget: (context, url, error) => Icon(Icons.error),
    );
                    
                  }).toList(),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height,
                    autoPlay: true,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    viewportFraction: 1.05,
                    enlargeCenterPage: true,
                    enlargeFactor: .2,
                    enlargeStrategy: CenterPageEnlargeStrategy
                        .scale, // استخدم هذه الخاصية لعمل تأثير الزووم
                    pageSnapping: true,

                    autoPlayInterval: Duration(seconds: 5),
                    autoPlayCurve: Curves.easeInOutCubicEmphasized,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 5000),
                  ),
                ),
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: kbackgroundcolor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: kmaincolor,
                        size: 19,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<GetcartitemsCubit>(context)
                        .fetchcartitems();
                    GoRouter.of(context).push('/CartScreen');
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          color: kbackgroundcolor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart_outlined,
                        color: kmaincolor,
                        size: 19,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.products.name!,
                          style: Textstyle.textStyle18.copyWith(
                                color: neutralColor3,fontWeight: FontWeight.w600
                                )
                        ),
                        const SizedBox(height: 9),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: accentColor1,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.products.location!.address!,
                              style:  Textstyle.textStyle16.copyWith(
                                color: neutralColor3,fontWeight: FontWeight.w600
                                )
                            ),
                          ],
                        ),
                       
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '\$${widget.products.price.toString()}/Person',
                        style:  Textstyle.textStyle15.copyWith(
                                color: neutralColor3,fontWeight: FontWeight.w600
                                )
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            FontAwesomeIcons.solidStar,
                            size: 16,
                            color: accentColor1,
                          ),
                          const SizedBox(width: 6.3),
                          Text(
                            textAlign: TextAlign.center,
                            widget.products.rating.toString(),
                            style:  Textstyle.textStyle15.copyWith(
                                color: neutralColor3,fontWeight: FontWeight.w600
                                )
                          ),
                          const SizedBox(width: 23),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 35,
                child: TabBar(
                  controller: _tabController,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  indicatorPadding: const EdgeInsets.all(0),
                  indicatorColor: kmaincolor,
                  indicatorWeight: .5,
                  dividerColor: const Color.fromARGB(255, 255, 248, 241),
                  dividerHeight: 2,
                  onTap: (value) {
                    setState(() {
                      index = value;
                    });
                  },
                  tabs: [
                    Tab(
                        child: Text('Overview',
                            style: Textstyle.textStyle15
                                .copyWith(color: kmaincolor))),
                    Tab(
                        child: Text('Details',
                            style: Textstyle.textStyle15
                                .copyWith(color: kmaincolor))),
                    Tab(
                        child: Text('Reviews',
                            style: Textstyle.textStyle15
                                .copyWith(color: kmaincolor))),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 18,
                            ),
                            Text(
                              widget.products.description!,
                              style:  Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w500,
                                height: 1.7)
                            ),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                       CircleAvatar(
                                        backgroundImage: NetworkImage(widget.products.guide!.photo!),

                                        radius: 25,
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            widget.products.guide!.name!,
                                            style:  Textstyle.textStyle16.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w700,
                                height: 1.4)
                                          ),
                                          Text(
                                            widget.products.guide!.email!,
                                            style:  Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w500,
                                height: 1.7)
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final roomId = await FireData().creatRoom(
                                        widget.products.guide!.id!,
                                        widget.products.guide!.name!,
                                        widget.products.guide!.photo!
                                      );
                                      GoRouter.of(context)
                                          .push('/ChatScreen', extra: [
                                        roomId,
                                        widget.products.guide!.name!,
                                       widget.products.guide!.photo!

                                      ]);
                                    },
                                    icon: const Icon(Icons.chat_rounded,
                                        color: kmaincolor),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(Icons.schedule,
                                          color: kmaincolor),
                                       Text(
                                        'Duration',
                                        style:  Textstyle.textStyle16.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w600,
                                height: 1.4)
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        '${widget.products.duration} Days',
                                        style:  Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w500,
                                height: 1.7)
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 55,
                                    child: const VerticalDivider(
                                      width: 1,
                                      thickness: 1,
                                      color: kmaincolor,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.group_outlined,
                                          color: kmaincolor),
                                       Text(
                                        'Group Size',
                                        style:  Textstyle.textStyle16.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w600,
                                height: 1.4)
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        widget.products.maxGroupSize.toString(),
                                        style:  Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w500,
                                height: 1.7)
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 55,
                                    child: const VerticalDivider(
                                      width: 1,
                                      thickness: 1,
                                      color: kmaincolor,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Icon(Icons.calendar_month_outlined,
                                          color: kmaincolor),
                                       Text(
                                        'Days',
                                        style:  Textstyle.textStyle16.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w600,
                                height: 1.4)
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        widget.products.startDays![0]
                                            .toString(),
                                        style:  Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w500,
                                height: 1.7)
                                      ),
                                      if (widget.products.startDays != null &&
                                          widget.products.startDays!.length >=
                                              2)
                                        Text(
                                          widget.products.startDays![1]
                                              .toString(),
                                          style:  Textstyle.textStyle13.copyWith(
                                color: neutralColor3,
                                fontWeight: FontWeight.w500,
                                height: 1.7)
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Rviewpagefortour(
                      products: widget.products,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: kbackgroundcolor,
        padding: const EdgeInsets.only(right: 30, left: 30, bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kmaincolor),
                  ),
                  onPressed: () {
                    GoRouter.of(context)
                        .push('/BookingPage', extra: widget.products);
                  },
                  child: const Text(
                    '  Book now  ',
                    style: TextStyle(
                      color: kbackgroundcolor,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
