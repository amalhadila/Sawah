import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:table_calendar/table_calendar.dart';

class TravelInfo extends StatefulWidget {
  @override
  _TravelInfoState createState() => _TravelInfoState();
}

class _TravelInfoState extends State<TravelInfo> {
  DateTime? _startDate;
  DateTime? _endDate;

  int groupSize = 1; // 1: 1-4, 2: 5-10, 3: More than 10
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text(
          'Landmark name',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Enter travel dates',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    TableCalendar(           
                      daysOfWeekHeight: 22,           
                      focusedDay: DateTime.now(),
                      firstDay: DateTime.utc(2000, 1, 1),
                      lastDay: DateTime.utc(2100, 12, 31),
                      calendarFormat: CalendarFormat.month,
                      selectedDayPredicate: (day) {
                        if (_startDate != null && _endDate != null) {
                          return day.isAfter(_startDate!.subtract(Duration(days: 1))) &&
                              day.isBefore(_endDate!.add(Duration(days: 1)));
                        } else if (_startDate != null) {
                          return isSameDay(day, _startDate);
                        } else {
                          return false;
                        }
                      },
                      calendarStyle: const CalendarStyle(
                        todayDecoration: BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
    selectedDecoration: BoxDecoration(
      color: kmaincolor, 
      shape: BoxShape.circle, 
    ),),
                      headerStyle: const HeaderStyle(
    titleCentered: true,
    formatButtonVisible: false,
  ),

                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          if (_startDate == null || (_startDate != null && _endDate != null)) {
                            _startDate = selectedDay;
                            _endDate = null;
                          } else if (_endDate == null) {
                            if (selectedDay.isBefore(_startDate!)) {
                              _startDate = selectedDay;
                            } else {
                              _endDate = selectedDay;
                            }
                          }
                        });
                      },
                    ),
                    SizedBox(height: 26),
                    Text(
                      'How many people will be on the tour?',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceChip(
                          checkmarkColor: Colors.black,
                          selectedColor: kCardColor,
                          side: BorderSide(color: kbackgroundcolor),
                          backgroundColor: kCardColor,
                          label: Text(
                            '1-4',
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          selected: groupSize == 1,
                          onSelected: (bool selected) {
                            setState(() {
                              groupSize = 1;
                            });
                          },
                        ),
                        ChoiceChip(
                          checkmarkColor: Colors.black,
                          selectedColor: kCardColor,
                          side: BorderSide(color: kbackgroundcolor),
                          backgroundColor: kCardColor,
                          label: Text('5-10', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          selected: groupSize == 2,
                          onSelected: (bool selected) {
                            setState(() {
                              groupSize = 2;
                            });
                          },
                        ),
                        ChoiceChip(
                          checkmarkColor: Colors.black,
                          selectedColor: kCardColor,
                          side: BorderSide(color: kbackgroundcolor),
                          backgroundColor: kCardColor,
                          label: Text('More than 10', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                          selected: groupSize == 3,
                          onSelected: (bool selected) {
                            setState(() {
                              groupSize = 3;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Comment for the guide',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter your comment',
                        filled: true,
                        fillColor: Color.fromARGB(255, 255, 248, 241),
                      ),
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 60),
            child: ElevatedButton(
              onPressed: _startDate != null && _endDate != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TravelInfo()),
                      );
                    }
                  : null,
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: kmaincolor,
                minimumSize: Size.fromHeight(50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
