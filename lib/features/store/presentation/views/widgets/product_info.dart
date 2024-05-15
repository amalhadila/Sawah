import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/store/data/products/products.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';

class ProductInfo extends StatefulWidget {
  final Products products;

  ProductInfo({Key? key, required this.products}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Container(
              height: MediaQuery.of(context).size.height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: kmaincolor,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push('/CartScreen');
                    },
                    child: const Icon(
                      Icons.shopping_cart,
                      color: kmaincolor,
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * .30,
            width: MediaQuery.of(context).size.width,
            child: const Image(
              fit: BoxFit.contain,
              image: AssetImage(
                  'assets/img/apple-watch-series-8-2.jpg'),
            ),
          ),
          Opacity(
            opacity: .7,
            child: Container(
              color: kbackgroundcolor,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.products.name!,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.products.description!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Price    \$${widget.products.price!}',
                      style: const TextStyle(
                          fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Material(
                            color: kmaincolor,
                            child: GestureDetector(
                              onTap: subtract,
                              child: const SizedBox(
                                height: 32,
                                width: 32,
                                child: Icon(Icons.remove),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          _quantity.toString(),
                          style: const TextStyle(fontSize: 35),
                        ),
                        ClipOval(
                          child: Material(
                            color: kmaincolor,
                            child: GestureDetector(
                              onTap: add,
                              child: const SizedBox(
                                height: 32,
                                width: 32,
                                child: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .08,
            child: Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(kmaincolor),
                  ),
                  onPressed: () {
                    BlocProvider.of<AdditemCubit>(context).addItemToCart(
                        id: widget.products.id, quantity: _quantity);
                  },
                  child: Text(
                    'Add to Cart'.toUpperCase(),
                    style: const TextStyle(
                        color: kbackgroundcolor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 15,)
        ],
      ),
    );
  }

  void subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  void add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }
}
