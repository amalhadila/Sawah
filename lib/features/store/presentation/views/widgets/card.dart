import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';

class productCard extends StatelessWidget {
  productCard(
      {Key? key,
      required this.imglink,
      required this.text,
      required this.ontap,
      required this.price});
  final dynamic price;
  final String imglink;
  final String text;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 50,
                color: kCardColor,
                spreadRadius: 20,
                offset: Offset(10, 10),
              ),
            ]),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      //imglink,
                      'assets/img/apple-watch-series-8-2.jpg',
                      height: MediaQuery.sizeOf(context).height * .15,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      text.substring(0, 6),
                      style: const TextStyle(
                          color: Color.fromARGB(255, 117, 115, 115),
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          r'$' '${price.toString()}',
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        // const Icon(
                        //   Icons.favorite,
                        //   color: Colors.red,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   right: 32,
          //   top: -60,
          //   child: Image.asset(
          //     imglink,
          //     height: 100,
          //     width: 100,
          //     fit: BoxFit.contain,
          //   ),
          // )
        ],
      ),
    );
  }
}
