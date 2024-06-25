import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/store/data/product/location.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/addtowishlist_cubit.dart';

class productCard extends StatefulWidget {
  final String imglink;
  final String id;
   List<Location>? address1;
  final String? address2;
  final dynamic? rating;
  final String text;
  final String? info;
  final dynamic price;
  final VoidCallback ontap;

  productCard({
    Key? key,
    required this.imglink,
    this.rating,
    required this.text,
    this.info,
    required this.ontap,
    required this.price,
    required this.id,   this.address1,  this.address2,
  }) : super(key: key);

  @override
  _productCardState createState() => _productCardState();
}

class _productCardState extends State<productCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define your responsive font sizes here
    double titleFontSize = screenWidth * 0.038;
    double priceFontSize = screenWidth * 0.036;
    double ratingFontSize = screenWidth * 0.036;

    return GestureDetector(
      onTap: widget.ontap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
               color: kbackgroundcolor,
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
            
            child: Card(
              shadowColor: ksecondcolor,
              
              color: kbackgroundcolor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(right: 0, left: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            widget.imglink,
                            height: screenHeight * .16,
                            width: screenWidth * .38,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isFavorite = !isFavorite;
                                BlocProvider.of<AddtowishlistCubit>(context)
                                    .addproducttowishlist(
                                  tourId: widget.id,
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Added to the wishlist')),
                                );
                              });
                            },
                            child: Icon(
                              isFavorite
                                  ? FontAwesomeIcons.solidHeart
                                  : FontAwesomeIcons.heart,
                              color: isFavorite ? kmaincolor : Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth *
                              0.43, 
                          child: Text(
                            widget.text,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              
                              color: ksecondcolor,
                              fontSize: titleFontSize,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 7),
                        Container(
                          width: screenWidth *
                              0.4, 
                          child: Column(
                            children: [
                              Row(
                                  children: [
                                    const Icon(
                              Icons.location_on,
                              color: klocicon,
                              size: 18,
                            ),
                             SizedBox(width: 4,),
                                    Text(
                                      widget.address1![0].address!,
                                      style: const TextStyle(
                                       
                                        fontSize: 13,
                                        color: ksecondcolor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ],
                          ),
                              if (
                                  widget.address1!.length >=2)
                                Row(
                                  children: [
                                    const Icon(
                              Icons.location_on,
                              color: klocicon,
                              size: 18,
                            ),
                             SizedBox(width: 4,),
                                    Text(
                                      widget.address1![1].address!,
                                      style: const TextStyle(
                                       
                                        fontSize: 13,
                                        color: ksecondcolor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ],
                          ),
                       ] ),),
                       const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 90,
                              child: Text(
                                r'price $' '${widget.price.toString()}',
                                style: TextStyle(
                                  fontSize: priceFontSize,
                                  color: ksecondcolor,
                                    fontWeight: FontWeight.bold,
                                               
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  FontAwesomeIcons.solidStar,
                                  size: 16,
                                  color: kmaincolor,
                                ),
                                const SizedBox(
                                  width: 6.3,
                                ),
                                Text(
                                  widget.rating.toString(),
                                  style: TextStyle(
                                    color: ksecondcolor,
                                    fontSize: ratingFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
