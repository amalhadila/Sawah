import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  int _quantity = 1;
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
            size: 26,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Booking',
          style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w600, color: kmaincolor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Departing from Osaka',
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
                        fontSize: 14,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Adults',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 25,
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
                      _quantity.toString(),
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
                  ])
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('US\$ 63.55',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w700)),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('go to payment',
                        style: TextStyle(
                            fontSize: 15,
                            color: kbackgroundcolor,
                            fontWeight: FontWeight.w700)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kmaincolor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
