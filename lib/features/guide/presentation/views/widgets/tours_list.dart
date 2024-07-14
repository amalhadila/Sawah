import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/features/guide/presentation/views/widgets/toursdetails.dart';
import 'package:sawah/features/guide/presentation/views/widgets/card.dart';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:sawah/auth/cach/cach_helper.dart';
import 'package:sawah/features/create_tour.dart/presentation/model/get_all_custom_tours_model.dart';
import '../../../../../auth/core_login/api/end_point.dart';
import '../../../../../core/utils/style.dart';
import '../../../../create_tour.dart/presentation/model/get_allAccpetedpricefromu.dart';
import 'toursdetailsscreanwithprice.dart';

class TourListScreen extends StatefulWidget {
  @override
  _TourListScreenState createState() => _TourListScreenState();
}

class _TourListScreenState extends State<TourListScreen>
    with SingleTickerProviderStateMixin {
  late Future<List<GetAllCustomToursModel>> _futureCustomTours;
  late Future<List<Tour>> _myAcceptedTours;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _futureCustomTours = getAllCustomTours();
    _myAcceptedTours = getAllAccepted(context); // Pass context here
  }

  Future<List<GetAllCustomToursModel>> getAllCustomTours() async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'https://sawahonline.com/api/v1/customizedTour',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}'
          },
        ),
      );
      dynamic responseData = response.data;
      log('Data fetched successfully');
      print(response.data); // Print the response data to debug

      if (responseData['data'] != null &&
          responseData['data']['docs'] != null) {
        List<GetAllCustomToursModel> getAllCustomToursModel =
            (responseData['data']['docs'] as List)
                .map((json) => GetAllCustomToursModel.fromJson(json))
                .toList();

        return getAllCustomToursModel;
      } else {
        // Handle the case where the expected data is not available
        return [];
      }
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened: $e, please try again"),
        ),
      );
      // Re-throw the error to propagate it further if needed
      throw e;
    }
  }

  Future<List<Tour>> getAllAccepted(BuildContext context) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'https://sawahonline.com/api/v1/customizedTour/accepted-tours',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}'
          },
        ),
      );
      dynamic responseData = response.data;
      log('Data fetched successfully');
      print(response.data); // Print the response data to debug

      if (responseData['data'] != null &&
          responseData['data']['acceptedTours'] != null) {
        List<Tour> getAllAccCustomToursModel =
            (responseData['data']['acceptedTours'] as List)
                .map((json) => Tour.fromJson(json))
                .toList();

        return getAllAccCustomToursModel;
      } else {
        // Handle the case where the expected data is not available
        return [];
      }
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened: $e, please try again"),
        ),
      );
      // Re-throw the error to propagate it further if needed
      throw e;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text(
          'Coming Orders',
          style: TextStyle(
              color: kmaincolor, fontSize: 19, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TabBar(
              labelStyle: Textstyle.textStyle15,
              controller: _tabController,
              indicator: BoxDecoration(
                color: kmaincolor,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: kbackgroundcolor,
              labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              tabs: [
                Tab(text: 'Active'),
                Tab(text: 'Accepted'),
              ],
              labelColor: kbackgroundcolor,
              unselectedLabelColor: Colors.grey,
              indicatorColor: kmaincolor,
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
        FutureBuilder<List<GetAllCustomToursModel>>(
  future: _futureCustomTours,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('An error occurred: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No data available'));
    } else {
      final toursList = snapshot.data!;
      final filteredToursList = toursList.where((tour) => tour.paymentStatus != 'paid').toList();
      
      return ListView.builder(
        itemCount: filteredToursList.length,
        itemBuilder: (context, index) {
          final tours = filteredToursList[index];
          final startDate = tours.startDate != null
              ? DateFormat('yyyy-MM-dd').format(tours.startDate!)
              : '';
          final endDate = tours.endDate != null
              ? DateFormat('yyyy-MM-dd').format(tours.endDate!)
              : '';
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tours.landmarks != null && tours.landmarks!.isNotEmpty)
                  ...tours.landmarks!.map((landmark) {
                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
                        child: GuideCard(
                          imageUrl: tours.user?.photo ?? '',
                          landmarkname: landmark.name ?? '',
                          date: '$startDate - $endDate',
                          username: tours.user?.name ?? '',
                          lang: tours.spokenLanguages?.join(', ') ?? '',
                          gov: tours.governorate ?? '',
                          groubsize: tours.groupSize,
                          price: null,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TourDetailsScreen(
                              tourId: tours.id ?? '', // Pass tour ID to TourDetailsScreen
                            ),
                          ),
                        );
                      },
                    );
                  }).toList()
              ],
            ),
          );
        },
      );
    }
  },
)
,
          FutureBuilder<List<Tour>>(
            future: _myAcceptedTours, // Use the instance variable
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('An error occurred: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No data available'));
              } else {
                final toursList = snapshot.data!;
                return ListView.builder(
                  itemCount: toursList.length,
                  itemBuilder: (context, index) {
                    final tour = toursList[index];
                    final startDate = tour.startDate != null
                        ? DateFormat('yyyy-MM-dd').format(tour.startDate!)
                        : '';
                    final endDate = tour.endDate != null
                        ? DateFormat('yyyy-MM-dd').format(tour.endDate!)
                        : '';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (tour.landmarks != null && tour.landmarks!.isNotEmpty)
                            ...tour.landmarks!.map((landmark) {
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 5.0),
                                  child: GuideCard(
                                    imageUrl: tour.user?.photo ?? '',
                                    landmarkname: landmark.name ?? '',
                                    date: '$startDate - $endDate',
                                    username: tour.user?.name ?? '',
                                    lang: tour.spokenLanguages?.join(', ') ?? '',
                                    gov: tour.governorate ?? '',
                                    price: tour.price,
                                    groubsize: tour.groupSize,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => tourdetailswithoutprice(
                                        tourId: tour.id ?? '', // Pass tour ID to TourDetailsScreen
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList()
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
