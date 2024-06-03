import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/store/data/products/products.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';

// class ProductInfo extends StatefulWidget {
//   final Products products;

//   ProductInfo({Key? key, required this.products}) : super(key: key);

//   @override
//   _ProductInfoState createState() => _ProductInfoState();
// }

// class _ProductInfoState extends State<ProductInfo> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
//             child: Container(
//               height: MediaQuery.of(context).size.height * .1,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(
//                       Icons.arrow_back_ios,
//                       color: kmaincolor,
//                       size: 26,
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       GoRouter.of(context).push('/CartScreen');
//                     },
//                     child: const Icon(
//                       Icons.shopping_cart,
//                       color: kmaincolor,
//                       size: 28,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: MediaQuery.of(context).size.height * .35,
//             width: MediaQuery.of(context).size.width,
//             child: const Image(
//               fit: BoxFit.contain,
//               image: AssetImage(
//                   'assets/img/apple-watch-series-8-2.jpg'),
//             ),
//           ),
//           Opacity(
//             opacity: .7,
//             child: Container(
//               color: kbackgroundcolor,
//               width: MediaQuery.of(context).size.width,
//               child: Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       widget.products.name!,
//                       style: const TextStyle(
//                           fontSize: 18, color:Colors.black,,fontWeight: FontWeight.w700),
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       widget.products.description!,
//                       style: const TextStyle(
//                           fontSize: 14,color:Colors.black, fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
          //             '200 \$',
          //           //  'Price    \$${widget.products!.price!}',
          //             style: const TextStyle(
          //                 fontSize: 16,color:Colors.black, fontWeight: FontWeight.w700),
          //           ),
          //           const SizedBox(
          //             height: 10,
          //           ),
                   
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
//           ButtonTheme(
//             minWidth: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * .08,
//             child: Builder(
//               builder: (context) => Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30),
//                 child: ElevatedButton(
//                   style: ButtonStyle(
//                     backgroundColor: WidgetStateProperty.all<Color>(kmaincolor),
//                   ),
//                   onPressed: () {
//                     BlocProvider.of<AdditemCubit>(context).addItemToCart(
//                         id: widget.products.id, quantity: _quantity);
//                   },
//                   child: Text(
//                     'Book now'.toUpperCase(),
//                     style: const TextStyle(
//                         color: kbackgroundcolor,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 15,)
//         ],
//       ),
//     );
//   }

//   
// }

class ProductInfo extends StatefulWidget {
   Products? products;

  ProductInfo({Key? key,  this.products}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> with SingleTickerProviderStateMixin {
 late TabController _tabController;
  int index = 0;

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
    return Scaffold(
      body: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),

        child: Column(
          children: [
            
            Stack(
              children:[ Container(
                height: MediaQuery.of(context).size.height * .4,
                width: MediaQuery.of(context).size.width,
                child: const Image(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/img/landmarks/pyramids2.jpg'),
                ),
              ),
              Positioned(                          
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
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
              height: 28,
              width: 28,
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
              height: 28,
              width: 28,
              decoration: const BoxDecoration(
                color: kbackgroundcolor,
                shape: BoxShape.circle,
              ),
            ),
            const Icon(
              Icons.shopping_cart,
              color: kmaincolor,
              size: 19,
            ),
          ],
        ),
      ),
    ],
  ),
)

                          ),
                        ),]
            ),
            TabBar(
              controller: _tabController,
              padding: EdgeInsets.symmetric(vertical: 7),
              indicator: BoxDecoration(
                color: Color.fromARGB(255, 252, 237, 227),
                borderRadius: BorderRadius.circular(12),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: kbackgroundcolor,
              isScrollable: true,
              onTap: (value) {
                setState(() {
                  index = value;
                });
              },
              tabs: [
                Tab(child: Text('   Information  ', style: Textstyle.textStyle15.copyWith(color: kmaincolor))),
                Tab(child: Text('     Reviews    ', style:Textstyle.textStyle15.copyWith(color: kmaincolor))),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * .75,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                      children: [
                        Container(
                          color: kbackgroundcolor,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.products?.name ?? 'Name',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  widget.products?.description ?? 'Product Description',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  '${widget.products?.price ?? 0} \$',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.all<Color>(kmaincolor),
                            ),
                            onPressed: () {
                              GoRouter.of(context)
                      .push('/BookingPage');
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
                        SizedBox(height: 15),
                      ],
                   
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Text('Reviews will be here'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}