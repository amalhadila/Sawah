import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  BookingPage({super.key, required this.product});
  final Product product;

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int quantity = 1;
  DateTime? _selectedDate;

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
        title: const Text(
          'Booking',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, color: kmaincolor),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select available date',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: ksecondcolor),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          DateTime initialDate = _getNextAvailableDate();
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1),
                            selectableDayPredicate: (DateTime date) {
                              // السماح بالتواريخ المتاحة فقط
                              return widget.product.startDays!.contains(DateFormat('EEEE').format(date));
                            },
                          );
                          if (pickedDate != null) {
                            setState(() {
                              _selectedDate = pickedDate;
                            });
                          }
                        },
                        child: Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : DateFormat('yyyy-MM-dd').format(_selectedDate!),
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Group Size ',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(
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
                      const Spacer()
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(r'Price:  $ ' '${widget.product.price.toString()}',
                      style: const TextStyle(
                          fontSize: 16,
                          color: ksecondcolor,
                          fontWeight: FontWeight.w700)),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: const Color.fromARGB(255, 252, 237, 227),
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
                            tourDate: DateFormat('yyyy-MM-dd').format(_selectedDate!),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Added to the cart')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select a date.')),
                          );
                        }
                      },
                      child: const Text('Add to cart',
                          style: TextStyle(
                              fontSize: 15,
                              color: kbackgroundcolor,
                              fontWeight: FontWeight.w700)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kmaincolor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedDate != null) {
                          // Navigate to payment
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please select a date.')),
                          );
                        }
                      },
                      child: const Text('Go to payment',
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
      });
    }
  }

  void add() {
    if (quantity < widget.product.maxGroupSize!.toInt()) {
      setState(() {
        quantity++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('The Max Group Size ${widget.product.maxGroupSize}')));
    }
  }

  DateTime _getNextAvailableDate() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      DateTime date = now.add(Duration(days: i));
      if (widget.product.startDays!.contains(DateFormat('EEEE').format(date))) {
        return date;
      }
    }
    return now; // return current date if no available date found, though ideally this should not happen
  }
}
