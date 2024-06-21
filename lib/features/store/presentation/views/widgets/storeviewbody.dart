import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/fetchwishlist_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/getcartitems_cubit.dart';
import 'package:graduation/features/store/presentation/views/widgets/searchdelegate.dart';
import 'package:graduation/features/store/presentation/views/widgets/store_products.dart';

class Storeviewbody extends StatelessWidget {
  const Storeviewbody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<GetcartitemsCubit>(context).fetchcartitems();
                    GoRouter.of(context).push('/CartScreen');
                  },
                  child: Icon(
                    Icons.shopping_cart_outlined,
                    color: kmaincolor,
                    size: 28,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<FetchwishlistCubit>(context).fetchwishlist();
                    GoRouter.of(context).push('/Wishlist');
                  },
                  child: Icon(
                    FontAwesomeIcons.heart,
                    color: kmaincolor,
                  ),
                ),
              ],
              
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6),
              child: Container(
                height: 45,
                width: 220,
                margin: EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(fontSize: 14),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 255, 248, 241),
                        ),
                        onTap: (){
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductSearchWidget(
                                  
                                )));
                        },
                       
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: store_product(),
    );
  }
}
