import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_my_requests_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/pages_response.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/select_cite.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/yourTourDetailsPage.dart';
import 'package:intl/intl.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<GetMyRequestsModel>> _myRequestsFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _myRequestsFuture = getMyRequests();
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
        'http://192.168.1.4:8000/api/v1/customizedTour/my-requests',
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
          },
        ),
      );

      dynamic responseData = response.data;
      print(responseData);

      List<GetMyRequestsModel> requests = (responseData['data']['requests'] as List)
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
        title:  Text('My orders',style: TextStyle(color: kmaincolor,fontSize: 19,fontWeight: FontWeight.w700),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0),
            child: TabBar(
              labelStyle:       Textstyle.textStyle15,
              controller: _tabController,
              indicator: BoxDecoration(
                color: kmaincolor,
                borderRadius: BorderRadius.circular(10),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: kbackgroundcolor,
              labelPadding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
              tabs: [
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
        )

      ),
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
          Center(child: Text('No completed orders')),
        ],
      ),
      
       
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CitySelectionScreen(
                              
                            ),
                          ),
                        );
        },
        label: Text('Create order',style: TextStyle(color: kbackgroundcolor),),
        icon: Icon(Icons.add,color: kbackgroundcolor,),
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
          location: order.governorate, // Assuming you have a location in your model
          date: order.startDate,
          status:order.status , 
          id:order.id,
          tour:order,
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
  

  OrderCard({super.key, this.name, this.tour, this.location, this.date, this.status, this.id});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
    return Card(
      color: ksecondcolor2,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 5,
      child: ListTile(minVerticalPadding: 22,
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
         leading:null,
        // CachedNetworkImage(
        //   imageUrl: imageUrl!,
        //   placeholder: (context, url) => CircularProgressIndicator(),
        //   errorWidget: (context, url, error) => Icon(Icons.error),
        //   imageBuilder: (context, imageProvider) => Container(
        //     width: 50,
        //     height: 50,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(8),
        //       image: DecorationImage(
        //         image: imageProvider,
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //   ),
        // ),
        title: Text(location!,style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700),),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              Text(formattedDate,style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w600),),
               Text(
                status!,
                style: TextStyle(color: accentColor3,fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
       trailing: 
              ElevatedButton(
               onPressed: status == 'cancelled' ? null : () {
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
            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700, color: status == 'canceled' ? Colors.black : Colors.white),
          ),
            
           
          
        ),
      ),
      
    );
  }
}
