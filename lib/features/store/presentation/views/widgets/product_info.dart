

import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/review_onlandmark/pres/comment.dart';
import 'package:graduation/features/review_onlandmark/pres/commentfortour.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
    _tabController = TabController(length:3, vsync: this);
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
      return Image.network(
        image,
        fit: BoxFit.cover,
        width: double.infinity,
      );
    }).toList(),
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height,
      autoPlay: true,
      initialPage: 0,
      enableInfiniteScroll: true,
      viewportFraction: 1,
      enlargeCenterPage: true,
      enlargeFactor: 0.2,
      enlargeStrategy: CenterPageEnlargeStrategy.scale, // استخدم هذه الخاصية لعمل تأثير الزووم
      pageSnapping: true,
      
      autoPlayInterval: Duration(seconds: 7),
      autoPlayCurve: Curves.easeInOutCubicEmphasized,
      autoPlayAnimationDuration: const Duration(milliseconds: 5000),
    ),
  ),
)

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
                      style: const TextStyle(
                        wordSpacing: .02,
                        letterSpacing: .01,
                        fontSize: 16,
                        color: ksecondcolor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 9),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: klocicon,
                          size: 18,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          widget.products.locations![0].address!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: ksecondcolor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    if (widget.products.startDays != null &&
                        widget.products.locations!.length >= 2)
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: klocicon,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            widget.products.locations![1].address!.toString(),
                            style: const TextStyle(
                              fontSize: 13,
                              color: ksecondcolor,
                              fontWeight: FontWeight.w600,
                            ),
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
                    style: const TextStyle(
                      wordSpacing: .02,
                      letterSpacing: .01,
                      fontSize: 14,
                      color: ksecondcolor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.solidStar,
                        size: 16,
                        color: kmaincolor,
                      ),
                      const SizedBox(width: 6.3),
                      Text(
                        textAlign: TextAlign.center,
                        widget.products.rating.toString(),
                        style: const TextStyle(
                          color: ksecondcolor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
                        style: Textstyle.textStyle15.copyWith(color: kmaincolor))),
                Tab(
                    child: Text('Details',
                        style: Textstyle.textStyle15.copyWith(color: kmaincolor))),
                Tab(
                    child: Text('Reviews',
                        style: Textstyle.textStyle15.copyWith(color: kmaincolor))),
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
                        SizedBox(height: 18,),
                        Text(
                          widget.products.description!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: ksecondcolor,
                            fontWeight: FontWeight.w600,
                          ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 10),
                          child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/profile_picture.png'),
          radius: 25,
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.products.guide!.name!,
              style: const TextStyle(
                color: ksecondcolor,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            Text(
              widget.products.guide!.email!,
              style: const TextStyle(
                color: ksecondcolor,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
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
        );
        GoRouter.of(context).push('/ChatScreen', extra: [
          roomId,
          widget.products.guide!.id!,
          widget.products.guide!.name!,
        ]);
      },
      icon: const Icon(Icons.chat_rounded, color: kmaincolor),
    ),
  ],
),

                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Icon(Icons.schedule, color: kmaincolor),
                                  const Text(
                                    'Duration',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kmaincolor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${widget.products.duration} Days',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ksecondcolor,
                                    ),
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
                                  const Icon(Icons.group_outlined, color: kmaincolor),
                                  const Text(
                                    'Group Size',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kmaincolor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    widget.products.maxGroupSize.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ksecondcolor,
                                    ),
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
                                  const Icon(Icons.calendar_month_outlined, color: kmaincolor),
                                  const Text(
                                    'Days',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kmaincolor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    widget.products.startDays![0].toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ksecondcolor,
                                    ),
                                  ),
                                  if (widget.products.startDays != null && widget.products.startDays!.length >= 2)
                                    Text(
                                      widget.products.startDays![1].toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ksecondcolor,
                                      ),
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
                SingleChildScrollView(
                  child: Center(child: Text('Reviews')),
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
                backgroundColor: MaterialStateProperty.all<Color>(kmaincolor),
              ),
              onPressed: () {
                GoRouter.of(context).push('/BookingPage', extra: widget.products);
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

