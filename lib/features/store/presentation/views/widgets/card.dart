import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/features/store/data/product/location.dart';
import 'package:sawah/features/store/presentation/manager/cubit/cubit/addtowishlist_cubit.dart';
import 'package:shimmer/shimmer.dart';

class productCard extends StatefulWidget {
  final dynamic imglink;
  final String id;
  Location? address1;
  final String? address2;
  final dynamic rating;
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
    required this.id,
    this.address1,
    this.address2,
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



    return GestureDetector(
      onTap: widget.ontap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kbackgroundcolor,
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(0, 6),
                    color: shadow,
                    spreadRadius: 1,
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
                            child:
                                CachedNetworkImage(
      imageUrl:  widget.imglink,
      width: screenWidth * .38,
      height:  screenHeight * .16,
      fit: BoxFit.fill,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: screenWidth * .38,
          height:  screenHeight * .16,
          color: Colors.white,
        ),
      ),errorWidget: (context, url, error) => Icon(Icons.error),
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
                      const SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: screenWidth * 0.43,
                            child: Text(
                              widget.text,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Textstyle.textStyle15.copyWith(color: neutralColor3,fontWeight: FontWeight.w800)
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: screenWidth * 0.4,
                            child: Column(children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: accentColor1,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    widget.address1!.address!,
                                    style: Textstyle.textStyle14.copyWith(color: neutralColor3,fontWeight: FontWeight.w700)
                                  ),
                                ],
                              ),
                              
                            ]),
                          ),
                          const SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 90,
                                child: Text(
                                  r'price $' '${widget.price.toString()}',
                                  style: Textstyle.textStyle14.copyWith(color: neutralColor3,fontWeight: FontWeight.w700)
                                ),
                              ),
                              SizedBox(width: 43),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.solidStar,
                                    size: 16,
                                    color: accentColor1,
                                  ),
                                  const SizedBox(
                                    width: 6.3,
                                  ),
                                  Text(
                                    widget.rating.toString(),
                                    style: Textstyle.textStyle14.copyWith(color: neutralColor3,fontWeight: FontWeight.w700)
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
          ),
        ],
      ),
    );
  }
}
