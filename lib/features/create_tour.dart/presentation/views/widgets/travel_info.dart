import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation/auth/cach/cach_helper.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_all_landmarks_by_govern_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/detailspage.dart';
import 'package:table_calendar/table_calendar.dart';

class TravelInfo extends StatefulWidget {
  final String selectedGovernorate;
  final List<String> selectedLanguages;
  final List<Landmark> selectedLandmarks;

  TravelInfo({
    required this.selectedGovernorate,
    required this.selectedLanguages,
    required this.selectedLandmarks,
  });

  @override
  _TravelInfoState createState() => _TravelInfoState();
}

class _TravelInfoState extends State<TravelInfo> {
  DateTime? _startDate;
  DateTime? _endDate;
  DateTime _focusedDay = DateTime.now();

  int groupSize = 1; // 1: 1-4, 2: 5-10, 3: More than 10
  TextEditingController commentController = TextEditingController();

  Future<void> createTour(BuildContext context,
      {String? governorate,
      List<String>? spokenLanguages,
      String? groupSize,
      List<String>? landmarks,
      String? startDate,
      String? endDate,
      String? commentForGuide}) async {
    final Dio _dio = Dio();
    try {
      print('Sending request with data:');
      print('Governorate: $governorate');
      print('Spoken Languages: $spokenLanguages');
      print('Group Size: $groupSize');
      print('Landmarks: $landmarks');
      print('Start Date: $startDate');
      print('End Date: $endDate');
      print('Comment for Guide: $commentForGuide');

      var response = await _dio.post(
        'http://192.168.1.4:8000/api/v1/customizedTour',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Token}',
            'Content-Type': 'application/json'
          },
        ),
        data: {
          "governorate": governorate,
          "spokenLanguages": spokenLanguages,
          "groupSize": groupSize,
          "landmarks": landmarks,
          "startDate": startDate,
          "endDate": endDate,
          "commentForGuide": commentForGuide,

        },
      );
      print('Response status code: ${response.statusCode}');

     
      print('Tour creation request successful');
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
      print('Tour creation request failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text(
          'Landmark name',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 19,
            color: kmaincolor,
          ),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Enter the start and the end date ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: kmaincolor,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      TableCalendar(
                        daysOfWeekHeight: 22,
                        focusedDay: _focusedDay,
                        firstDay: DateTime.utc(2000, 1, 1),
                        lastDay: DateTime.utc(2100, 12, 31),
                        calendarFormat: CalendarFormat.month,
                        selectedDayPredicate: (day) {
                          if (_startDate != null && _endDate != null) {
                            return day.isAfter(
                                    _startDate!.subtract(Duration(days: 1))) &&
                                day.isBefore(
                                    _endDate!.add(Duration(days: 1)));
                          } else if (_startDate != null) {
                            return isSameDay(day, _startDate);
                          } else {
                            return false;
                          }
                        },
                        calendarStyle: const CalendarStyle(
                          defaultTextStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: kmaincolor,
                          ),
                          todayDecoration: BoxDecoration(
                            color: accentColor3,
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: kCardColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          titleTextStyle: TextStyle(
                            color: kmaincolor,
                            fontWeight: FontWeight.w600,
                          ),
                          titleCentered: true,
                          formatButtonVisible: false,
                        ),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _focusedDay = focusedDay; // Keep the focused day in sync
                            if (_startDate == null ||
                                (_startDate != null && _endDate != null)) {
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kmaincolor,
                        ),
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
                              style: TextStyle(
                                color: groupSize == 1
                                    ? kbackgroundcolor
                                    : kmaincolor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
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
                            label: Text(
                              '5-10',
                              style: TextStyle(
                                color: groupSize == 2
                                    ? kbackgroundcolor
                                    : kmaincolor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                            label: Text(
                              'More than 10',
                              style: TextStyle(
                                color: groupSize == 3
                                    ? kbackgroundcolor
                                    : kmaincolor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: kmaincolor,
                        ),
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
      createTour(
        context,
        governorate: widget.selectedGovernorate,
        spokenLanguages: widget.selectedLanguages,
        groupSize: groupSize == 1 ? '1-4' : groupSize == 2 ? '5-10' : 'More than 10',
        landmarks: widget.selectedLandmarks.map((e) => e.id).toList(),
        startDate: _startDate.toString(),
        endDate: _endDate.toString(),
        commentForGuide: commentController.text,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TourDetailsPage(
            selectedGovernorate: widget.selectedGovernorate,
            selectedLanguages: widget.selectedLanguages,
            selectedLandmarks: widget.selectedLandmarks,
            startDate: _startDate!,
            endDate: _endDate!,
            groupSize: groupSize,
            comment: commentController.text,
          ),
        ),
      );
    }
  : () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please, select the start and the end date'),
        ),
      );
    },

                style: ElevatedButton.styleFrom(
                  backgroundColor: kmaincolor,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: kbackgroundcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
