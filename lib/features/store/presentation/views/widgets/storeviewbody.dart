import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
                child: Row(
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: kmaincolor,
                      size: 28,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      FontAwesomeIcons.heart,
                      color: kmaincolor,
                    ),
                  ],
                ),
              ))
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                height: 35,
                width: 180,
                margin: EdgeInsets.only(top: 4),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                      ),
                      hintText: "Find Product",
                      hintStyle: TextStyle(fontSize: 14),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Color.fromARGB(255, 255, 248, 241),
                    ),
                  )),
                ]),
              ),
            ),
          ],
        ),
      ),
      body: store_product(),
    );
  }
}
