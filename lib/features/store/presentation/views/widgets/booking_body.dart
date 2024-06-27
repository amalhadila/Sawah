import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/checkavailability_cubit.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';


class BookingPage extends StatefulWidget {
  BookingPage({super.key, required this.product});
  final Product product;

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int quantity = 1;
  DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();

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
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.name!,
                    style: const TextStyle(
                      color: kmaincolor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Select available date',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kmaincolor),
                        ),
                       
                      TableCalendar(
                            daysOfWeekHeight: 22, 
                            firstDay: DateTime.now(),
                            lastDay: DateTime(DateTime.now().year + 1),
                            focusedDay: _focusedDay,
                            availableCalendarFormats: const {
                              CalendarFormat.month: '',
                            },
                            calendarStyle: const CalendarStyle(
                              defaultTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
                              todayDecoration: BoxDecoration(
                                color: accentColor3,
                                 shape: BoxShape.circle,
                              ),
                              selectedDecoration: BoxDecoration(
                                color: ksecondcolor, 
                                shape: BoxShape.circle,
                              ),
                            ),
                           
                            headerStyle: const HeaderStyle(
                              titleTextStyle: TextStyle(color: kmaincolor, fontWeight: FontWeight.w600),
                              titleCentered: true,
                              formatButtonVisible: false,
                            ),
                            onDaySelected: (selectedDay, focusedDay) {
                              setState(() {
                                _selectedDate = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            },
                            
                            selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
                             enabledDayPredicate: (date) {
                        return widget.product.startDays!.contains(DateFormat('EEEE').format(date));
                      },
                      
                          ),
                      ],
                      
                    ),
                  ),
                  
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                          'Group Size ',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kmaincolor),
                        ),
                        const SizedBox(
                      height: 20,
                    ),
                            Text(r'Price: ',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: kmaincolor,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ),
                                Spacer(),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
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
                                    size: 24,
                                    color: kmaincolor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            quantity.toString(),
                            style: const TextStyle(
                                fontSize: 25, color: kmaincolor),
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
                                    size: 24,
                                    color: kmaincolor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                      height: 20,
                    ),
                             Text(r'$'' ${widget.product.price.toString()} ',
                                                   style: const TextStyle(
                                fontSize: 16,
                                color: kmaincolor,
                                fontWeight: FontWeight.w700)),
                           ],
                         ),
                      ],
                    ),
                  ),
                          
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
             // color: const Color.fromARGB(255, 252, 237, 227),
              padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_selectedDate != null) {

  var isAvailable = await BlocProvider.of<CheckavailabilityCubit>(context)
      .checkAvailability(
        Id: widget.product.id!,
        groupSize: quantity,
        tourDate: '"${DateFormat('yyyy-MM-dd').format(_selectedDate!)}"',
      );
     print('"${DateFormat('yyyy-MM-dd').format(_selectedDate!)}"');
  if (isAvailable) {
    BlocProvider.of<AdditemCubit>(context).addItemToCart(
      tourId: widget.product.id,
      Adults: quantity,
      tourDate: "${DateFormat('yyyy-MM-dd').format(_selectedDate!)}",
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to the cart')),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('${widget.product.name} is not available')),
    );
  }
} else {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Please select a date.')),
  );
};

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kmaincolor,
                      ),
                      child: const Text('Add to cart',
                          style: TextStyle(
                              fontSize: 15,
                              color: kbackgroundcolor,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async{
                        if (_selectedDate != null) {
                          var isAvailable = await BlocProvider.of<CheckavailabilityCubit>(context)
      .checkAvailability(
        Id: widget.product.id!,
        groupSize: quantity,
        tourDate: "${DateFormat('yyyy-MM-dd').format(_selectedDate!)}",
      );
     print(DateFormat('yyyy-MM-dd').format(_selectedDate!));
  if (isAvailable) {
    BlocProvider.of<AdditemCubit>(context).addItemToCart(
      tourId: widget.product.id,
      Adults: quantity,
      tourDate: "${DateFormat('yyyy-MM-dd').format(_selectedDate!)}",
    ); } else {
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text('${widget.product.name} is not available')),
    );
  }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please select a date.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kmaincolor,
                      ),
                      child: const Text('Go to payment',
                          style: TextStyle(
                              fontSize: 15,
                              color: kbackgroundcolor,
                              fontWeight: FontWeight.w700)),
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