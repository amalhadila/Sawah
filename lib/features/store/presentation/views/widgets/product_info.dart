import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/review_onlandmark/pres/comment.dart';
import 'package:graduation/features/review_onlandmark/pres/commentfortour.dart';
import 'package:graduation/features/store/data/product/product.dart';
class ProductInfo extends StatefulWidget {
  final Product products;

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
    return 
    
    Scaffold(      
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                
                Container(
                  height: MediaQuery.of(context).size.height * .44,
                  width: MediaQuery.of(context).size.width,
                  child: const Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/img/landmarks/pyramids2.jpg'),
                  ),
                ),
                Positioned(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .08,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
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
                            GestureDetector(
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
                          ],
                        ),
                      )),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
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
                              Text(
   widget.products.locations![0].address! ,
  style: const TextStyle(
    wordSpacing: .02,
    letterSpacing: .01,
    fontSize: 13,
    color: ksecondcolor,
    fontWeight: FontWeight.w500,
  ),
),

 if (widget.products.startDays != null && widget.products.locations!.length >= 2)
      Text(
       widget.products.locations![1].address!.toString(),
        style: const TextStyle(
    wordSpacing: .02,
    letterSpacing: .01,
    fontSize: 13,
    color: ksecondcolor,
    fontWeight: FontWeight.w500,
  ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.solidStar,
                                  size: 16,
                                  color: kmaincolor,
                                ),
                                SizedBox(
                                  width: 6.3,
                                ),
                                Text(
                                  widget.products.rating.toString(),
                                  style: TextStyle(
                                    color: ksecondcolor,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    TabBar(
                      controller: _tabController,
                      padding: EdgeInsets.symmetric(vertical: 0),
                      indicatorPadding: EdgeInsets.all(0),
                      indicatorColor: kmaincolor,
                      indicatorWeight: 1,
                      dividerColor: Color.fromARGB(255, 255, 248, 241),
                      dividerHeight: 2,
                      isScrollable: true,
                      onTap: (value) {
                        setState(() {
                          index = value;
                        });
                      },
                      tabs: [
                        Tab(
                            child: Text('   Information  ',
                                style: Textstyle.textStyle15
                                    .copyWith(color: kmaincolor))),
                        Tab(
                            child: Text('     Details    ',
                                style: Textstyle.textStyle15
                                    .copyWith(color: kmaincolor))),
                        Tab(
                            child: Text('     reviews    ',
                                style: Textstyle.textStyle15
                                    .copyWith(color: kmaincolor))),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .6,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Column(
                            children: [
                              Container(
                                color: kbackgroundcolor,
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 5),
                                      Text(
                                         widget.products.description!,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: ksecondcolor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            Icon(Icons.schedule,
                                                color: kmaincolor),
                                            Text(
                                              'Duration',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kmaincolor),
                                            ),
                                            Text(
                                              widget.products.duration.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ksecondcolor),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.group_outlined,
                                              color: kmaincolor,
                                            ),
                                            Text(
                                              'maxGroupSize',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kmaincolor),
                                            ),
                                            Text(
                                               widget.products.maxGroupSize
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ksecondcolor),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Icon(
                                              Icons.calendar_today_outlined,
                                              color: kmaincolor,
                                            ),
                                            Text(
                                              'day',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kmaincolor),
                                            ),
                                            Text(
                                               widget.products.startDays![0]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: ksecondcolor),
                                            ),
                                            if (widget.products.startDays != null && widget.products.startDays!.length >= 2)
      Text(
        widget.products.startDays![1].toString(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: ksecondcolor,
        ),
      ),
                                          ],
                                        ),
                                        
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),Rviewpagefortour( products:widget.products,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
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
                            WidgetStateProperty.all<Color>(kmaincolor),
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
        ),
      ]),
    );
    
      }
    
  }  


