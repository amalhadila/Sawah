import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/widgets/custom_error_msg.dart';
import 'package:graduation/core/widgets/loading_widget.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/checkavailability_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/deleteitem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/getcartitems_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/productbyid_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/productbyid_state.dart';
import 'package:intl/intl.dart';
import 'package:graduation/features/store/presentation/views/widgets/payment_web_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/features/store/presentation/views/widgets/payment_response.dart';

class CartScreen extends StatelessWidget {
  final Dio _dio = Dio();
  Future<void> pay(BuildContext context)async{
    try {
    
      var response = await _dio.post(
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
             'Authorization' :'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2NjMwZDllZTc2NjAwZmQwNmZjN2ViMiIsImlhdCI6MTcxNzc3Njk2NCwiZXhwIjoxNzI1NTUyOTY0fQ.GJvTEzdygj9EKYq7lIRx5ORsrlRUOPyYcs1wkQxm_OY',
          },
        ),
        'http://192.168.1.2:8000/api/v1/bookings/cart-checkout-session/665dc7b7520e8e6b1ac908f2',
        data: {
          "firstName":"Amr",
       "lastName":"Kfr",
        "phone":1010101001},
      );
      PaymentResponse paymentResponse =
          PaymentResponse.fromJson(response.data);
      Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) =>
            PaymentWebView(
            paymentResponse: paymentResponse),
      ));
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
    }
  }
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
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kmaincolor),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kmaincolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
                            child: GestureDetector(
                              onTap:  () async {
                                await BlocProvider.of<ProductbyidCubit>(context)
                                    .fetchProductbyId(productId:item.tour.id!);
                                var productState = BlocProvider.of<ProductbyidCubit>(context).state;
                                if (productState is productbyiduccess) {
                                  GoRouter.of(context).push(
                                    '/productinfo',
                                    extra: productState.product,
                                  );
                                } else if (productState is ProductbyFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(productState.errMessage)),
                                  );
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color.fromARGB(255, 255, 248, 241),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 4,
                                      offset: Offset(0, 5),
                                      color: Color.fromARGB(64, 85, 61, 51),
                                      spreadRadius: 0,
                                      blurStyle: BlurStyle.normal,
                                    ),
                                  ],
                                ),
                                height: screenHeight * .19,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 5),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          'assets/img/landmarks/pyramids2.jpg',
                                          height: MediaQuery.sizeOf(context).height * .13,
                                          width: MediaQuery.sizeOf(context).width * .23,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 12),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item.tour?.name ?? '',
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const Icon(Icons.calendar_month_outlined, color: kmaincolor),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    ' ${DateFormat('yyyy-MM-dd').format(item.tourDate)} ',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const Icon(Icons.group_outlined, color: kmaincolor),
                                                  const SizedBox(width: 2),
                                                  Text(
                                                    ' ${item.groupSize} ',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  const Text(
                                                    'people',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                'price \$${item.itemPrice}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          var itemId = item.id;
                                          print('Deleting item with id: $itemId');
                                          BlocProvider.of<DeleteitemCubit>(context)
                                              .deleteitem(Id: itemId);
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline_rounded,
                                          size: 29,
                                          color: kmaincolor,
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
                    ),
                    ElevatedButton(

onPressed: () async {
  bool allItemsAvailable = true;
  
  for (var item in cartItems) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(item.tourDate);
    print("Checking availability for item ID: ${item.id}, groupSize: ${item.groupSize}, tourDate: $formattedDate");

    var isAvailable = await BlocProvider.of<CheckavailabilityCubit>(context)
        .checkAvailability(
          Id: item.tour.id,
          groupSize: item.groupSize,
          tourDate: formattedDate,
        );
    print("isAvailable: $isAvailable");

    if (!isAvailable) {
      allItemsAvailable = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item.tour?.name} is not available')),
      );                           
    } else {
      /////////////////////////////////////////////////////
    }
  }

  if (allItemsAvailable) {
    print(allItemsAvailable);
    await pay(context);
    // Navigate to payment screen
  }
},



                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kmaincolor,
                      ),
                      child: const Text(
                        'Go to payment',
                        style: TextStyle(
                          fontSize: 15,
                          color: kbackgroundcolor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  height: screenHeight - (screenHeight * .08) - appBarHeight - statusBarHeight,
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
              return const Center(child: LoadingWidget());
            }
          },
        ),
      ),
    );
  }
}
