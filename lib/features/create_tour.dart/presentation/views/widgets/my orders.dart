import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/features/create_tour.dart/presentation/model/get_my_requests_model.dart';
import 'package:sawah/features/create_tour.dart/presentation/views/widgets/pages_response.dart';
import 'package:sawah/features/create_tour.dart/presentation/views/widgets/select_city.dart';
import 'package:sawah/features/create_tour.dart/presentation/views/widgets/yourTourDetailsPage.dart';
import 'package:intl/intl.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<GetMyRequestsModel>> _myRequestsFuture;
    late Future<List<GetMyRequestsModel>> _mycompleteRequestsFuture;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _myRequestsFuture = getMyRequests();
    _mycompleteRequestsFuture = getMycompleteRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<GetMyRequestsModel>> getMyRequests() async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'https://sawahonline.com/api/v1/customizedTour/my-requests',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Token}',
          },
        ),
      );

      dynamic responseData = response.data;
      print(responseData);

      List<GetMyRequestsModel> requests =
          (responseData['data']['requests'] as List)
              .map((json) => GetMyRequestsModel.fromJson(json))
              .toList();

      return requests;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
      throw e; // rethrowing the exception to handle it further if needed
    }
  }
  
  Future<List<GetMyRequestsModel>> getMycompleteRequests() async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'https://sawahonline.com/api/v1/customizedTour/my-requests?status=completed',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${Token}',
          },
        ),
      );

      dynamic responseData = response.data;
       print('complete');
      print(responseData);

      List<GetMyRequestsModel> requests =
          (responseData['data']['requests'] as List)
              .map((json) => GetMyRequestsModel.fromJson(json))
              .toList();

      return requests;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
      throw e; // rethrowing the exception to handle it further if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                  backgroundColor: kbackgroundcolor,
          title: const Text(
            'My orders',
            style: Textstyle.textStyle21,
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(45),
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
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                tabs:const [
                   Expanded(
                    child: Tab(
                      text: 'Active',
                    ),
                  ),
                  Expanded(
                    child: Tab(
                      text: 'Completed',
                    ),
                  ),
                ],
                labelColor: kbackgroundcolor,
                unselectedLabelColor: kmaincolor,
              ),
            ),
          )),
      body: TabBarView(
        controller: _tabController,
        children: [
          FutureBuilder<List<GetMyRequestsModel>>(
            future: _myRequestsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No active orders'));
              }

              return OrdersList(orders: snapshot.data!);
            },
          ),
             FutureBuilder<List<GetMyRequestsModel>>(
            future: _mycompleteRequestsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No completed orders'));
              }

              return OrdersList(orders: snapshot.data!);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CitySelectionScreen(),
            ),
          );
        },
        label: Text(
          'Create order',
          style: Textstyle.textStyle15.copyWith(color: kbackgroundcolor),
        ),
        icon: Icon(
          Icons.add,
          color: kbackgroundcolor,
        ),
        backgroundColor: kmaincolor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class OrdersList extends StatelessWidget {
  final List<GetMyRequestsModel> orders;

  OrdersList({required this.orders});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderCard(
          name: order.landmarks![0].name,
          location:
              order.governorate, // Assuming you have a location in your model
          date: order.startDate,
          status: order.status,
          id: order.id,
          tour: order,
        );
      },
    );
  }
}

class OrderCard extends StatelessWidget {
  final String? name;
  GetMyRequestsModel? tour;
  final String? id;
  final String? location;
  final DateTime? date;
  final String? status;

  OrderCard(
      {super.key,
      this.name,
      this.tour,
      this.location,
      this.date,
      this.status,
      this.id});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
    return Card(
      color: ksecondcolor2,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: ListTile(
        minVerticalPadding: 22,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TourDetailsPage(
                tour: tour!,
              ),
            ),
          );
        },
        leading: null,
   
        title: Text(
          location!,
          style: Textstyle.textStyle16.copyWith(color:neutralColor3 ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formattedDate,
                style:
                   Textstyle.textStyle15.copyWith(color:neutralColor3 ),
              ),
              Text(
                status!,
                style:
                    Textstyle.textStyle15.copyWith(color:accentColor3),
              ),
            ],
          ),
        ),
        trailing: ElevatedButton(
          onPressed: status == 'cancelled'
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResponseScreen(
                        tourId: id!,
                        tourname: name!,
                      ),
                    ),
                  );
                },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            backgroundColor: status == 'canceled' ? neutralColor : kmaincolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            'View Guides',
            style: Textstyle.textStyle13.copyWith(
                color: kbackgroundcolor),
          ),
        ),
      ),
    );
  }
}
