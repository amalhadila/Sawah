import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key, required this.product});
  Product product;

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int quantity = 1;
  DateTime? _selectedDate;

  void _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
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
        title: Text(
          'Booking',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kmaincolor),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Check availability',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _pickDate(context);
                        },
                        child: _selectedDate == null
                            ? Text(
                                'June 4 - Oct 31',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: kbackgroundcolor),
                              )
                            : Text(
                                ' ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: kbackgroundcolor),
                              ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kmaincolor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Group Size',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Row(children: [
                        ClipOval(
                          child: Material(
                            color: kbackgroundcolor,
                            child: GestureDetector(
                              onTap: subtract,
                              child: const SizedBox(
                                height: 27,
                                width: 27,
                                child: Icon(
                                  Icons.remove,
                                  size: 26,
                                  color: kmaincolor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(fontSize: 25),
                        ),
                        ClipOval(
                          child: Material(
                            color: kbackgroundcolor,
                            child: GestureDetector(
                              onTap: add,
                              child: const SizedBox(
                                height: 25,
                                width: 25,
                                child: Icon(
                                  Icons.add,
                                  size: 26,
                                  color: kmaincolor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Spacer()
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(r'Price:  $ ' '${widget.product.price.toString()}',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Color.fromARGB(255, 252, 237, 227),
              padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedDate != null) {
                          BlocProvider.of<AdditemCubit>(context).addItemToCart(
                            tourId: widget.product.id,
                            Adults: quantity,
                            tourDate: _selectedDate!.toString(),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('added to the cart')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a date.')),
                          );
                        }
                      },
                      child: Text('Add to cart',
                          style: TextStyle(
                              fontSize: 15,
                              color: kbackgroundcolor,
                              fontWeight: FontWeight.w700)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kmaincolor,
                      ),
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedDate != null) {
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please select a date.')),
                          );
                        }
                      },
                      child: Text('Go to payment',
                          style: TextStyle(
                              fontSize: 15,
                              color: kbackgroundcolor,
                              fontWeight: FontWeight.w700)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kmaincolor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void subtract() {
    if (quantity > 1) {
      setState(() {
        quantity--;
        print(quantity);
      });
    }
  }

  void add() {
    if (quantity < widget.product.maxGroupSize!.toInt()) {
      setState(() {
        quantity++;
        print(quantity);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The Max Group Size ${widget.product.maxGroupSize}')));
    }
  }
}
