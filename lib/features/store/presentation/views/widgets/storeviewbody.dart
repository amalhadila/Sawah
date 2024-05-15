import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/store/presentation/views/widgets/store_products.dart';

class Storeviewbody extends StatelessWidget {
  const Storeviewbody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
              onTap: () {
                GoRouter.of(context).push('/CartScreen');
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.shopping_cart,
                  color: kmaincolor,
                  size: 32,
                ),
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(color: kmaincolor,fontSize: 32, fontWeight: FontWeight.w900),
        ),
      ),
      body: store_product(),
    );
  }
}
