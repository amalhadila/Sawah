import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/features/guide/presentation/views/widgets/send_price.dart';

import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:intl/intl.dart';
import 'package:sawah/auth/cach/cach_helper.dart';

import 'package:sawah/features/create_tour.dart/presentation/model/get_custom_tour_by_id_model.dart';


import '../../../../../auth/core_login/api/end_point.dart';

class tourdetailswithoutprice extends StatefulWidget {
  final String tourId; // Define a tourId property

  tourdetailswithoutprice({
    required this.tourId, // Constructor to receive tourId
  });

  @override
  _tourdetailswithoutpriceState createState() => _tourdetailswithoutpriceState();
}

class _tourdetailswithoutpriceState extends State<tourdetailswithoutprice> {
  late Future<GetCustomTourByIdModel> _futureTourDetails;

  @override
  void initState() {
    super.initState();
    _futureTourDetails = getCustomTourById(widget.tourId);
  }

  Future<GetCustomTourByIdModel> getCustomTourById(String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'https://sawahonline.com/api/v1/customizedTour/$tourId',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}',
          },
        ),
      );
      dynamic responseData = response.data;
      log('Data fetched successfully');
      print(response.data); // Print the response data to debug

      if (responseData['data']['doc'] != null) {
        return GetCustomTourByIdModel.fromJson(responseData['data']['doc']);
      } else {
        // Handle the case where the expected data is not available
        throw Exception('Data not found');
      }
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error occurred: $e, please try again"),
        ),
      );
      // Re-throw the error to propagate it further if needed
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kmaincolor,
        title: Text('Tour Details',style: TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder<GetCustomTourByIdModel>(
        future: _futureTourDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          } else {
            log('message');
            print(snapshot.data);
            final tourDetails = snapshot.data!;
            final startDate = tourDetails.startDate != null
                ? DateFormat('yyyy-MM-dd').format(tourDetails.startDate!)
                : '';
            final endDate = tourDetails.endDate != null
                ? DateFormat('yyyy-MM-dd').format(tourDetails.endDate!)
                : '';

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  children: [
                    _buildCard(
                      context,
                      'The destination',
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tourDetails.governorate ?? 'Unknown',
                            style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          GestureDetector(
                            onTap: () {},
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: screenWidth * 0.05),
                                SizedBox(width: screenWidth * 0.02),
                                Row(
                                  children: [
                                    Text(
                                      "$startDate".split(' ')[0],
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.04),
                                    ),
                                    Text(' - '),
                                    Text(
                                      "$endDate".split(' ')[0],
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.04),
                                    ),
                                  ],
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    _buildCard(
                      context,
                      'the landmarks',
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: tourDetails.landmarks?.map((landmark) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: screenWidth * 0.01),
                            child: Text(
                              landmark.name ?? 'Unknown',
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          );
                        }).toList() ?? [Text('No landmarks available')],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    _buildCard(
                      context,
                      'Tour details',
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRowWithEdit(
                              context,
                              'Tour languages',
                              tourDetails.spokenLanguages?.join(', ') ?? '',
                              screenWidth),
                          SizedBox(height: screenWidth * 0.02),
                          Text('How many people will be on the tour?'),
                          _buildRowWithEdit(
                              context,
                              tourDetails.groupSize == '1-4'
                                  ? '1-4'
                                  : tourDetails.groupSize == '5-10'
                                      ? '5-10'
                                      : 'More than 10',
                              '',
                              screenWidth),
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.04),
                    _buildCard(
                      context,
                      'Comment for Guide',
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          SizedBox(height: screenWidth * 0.02),
                          Text(
                            tourDetails.commentForGuide ?? 'No comments available',
                            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenWidth * 0.08),
                  ]
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Widget child) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: screenWidth * 0.02),
              child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowWithEdit(BuildContext context, String title, String value,
      double screenWidth) {
    return Row(
      children: [
        Text(title, style: TextStyle(fontSize: screenWidth * 0.04)),
        SizedBox(width: screenWidth * 0.035),
        Text(
          value,
          style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.black54),
        ),
        SizedBox(width: screenWidth * 0.01),
      ],
    );
  }
}
