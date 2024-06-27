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
          style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19,color: kmaincolor),
        ),
        centerTitle: true,
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter the start and the end date ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: kmaincolor),
                      ),
                      const SizedBox(height: 16.0),
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
                          defaultTextStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: kmaincolor),
                          todayDecoration: BoxDecoration(
        color: accentColor3,
        shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
        color: kCardColor, 
        shape: BoxShape.circle, 
            ),),
                        headerStyle: const HeaderStyle(
                          titleTextStyle: TextStyle(color: kmaincolor,fontWeight: FontWeight.w600),
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
                      SizedBox(height: 30),
                      Text(
                        'How many people will be on the tour?',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: kmaincolor),
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ChoiceChip(
                            checkmarkColor: kbackgroundcolor,
                            selectedColor: accentColor3,
                            side: BorderSide(color: kbackgroundcolor),
                            backgroundColor: shadow,
                            label: Text(
                              '1-4',
                              style: TextStyle(color: groupSize == 1 ? kbackgroundcolor : kmaincolor,fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            selected: groupSize == 1,
                            onSelected: (bool selected) {
                              setState(() {
                                groupSize = 1;
                              });
                            },
                          ),
                          ChoiceChip(
                            checkmarkColor: kbackgroundcolor,
                            selectedColor: accentColor3,
                            side: BorderSide(color: kbackgroundcolor),
                            backgroundColor: shadow,
                            label: Text('5-10', style: TextStyle(color: groupSize == 2 ? kbackgroundcolor : kmaincolor,fontSize: 15, fontWeight: FontWeight.bold)),
                            selected: groupSize == 2,
                            onSelected: (bool selected) {
                              setState(() {
                                groupSize = 2;
                              });
                            },
                          ),
                          ChoiceChip(
                            checkmarkColor: kbackgroundcolor,
                            selectedColor: accentColor3,
                            side: BorderSide(color: kbackgroundcolor),
                            backgroundColor: shadow,
                            label: Text('More than 10', style: TextStyle(color: groupSize == 3 ? kbackgroundcolor : kmaincolor,fontSize: 15, fontWeight: FontWeight.bold)),
                            selected: groupSize == 3,
                            onSelected: (bool selected) {
                              setState(() {
                                groupSize = 3;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 27),
                      Text(
                        'Comment for the guide',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: kmaincolor),
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
                          fillColor: shadow,
                        ),
                        maxLines: 4,
                      ),
                      SizedBox(height: 30),
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
                    : (){ ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please, select the start and the end date')));
        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kmaincolor,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(color: kbackgroundcolor, fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
