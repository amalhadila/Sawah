import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation/auth/cach/cach_helper.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_my_requests_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/my%20orders.dart';
import 'package:intl/intl.dart';

Future cancelTour(BuildContext context, String tourId) async {
  final Dio _dio = Dio();
  try {
    print('Cancel tour request sent');
    var response = await _dio.patch(
      options: Options(
        headers: {
          'Authorization':
              'Bearer ${Token}',
        },
      ),
      'http://192.168.1.4:8000/api/v1/customizedTour/$tourId/cancel',
    );
    print('Cancel tour request successful');
  } catch (e) {
    print('Cancel tour request failed: $e');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Operation Failed"),
        content: Text("An error happened $e, please try again"),
      ),
    );
  }
}

class TourDetailsPage extends StatefulWidget {
  final GetMyRequestsModel tour;

  TourDetailsPage({required this.tour});

  @override
  _TourDetailsPageState createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour Details', style: TextStyle(color: kmaincolor,fontSize: 19,fontWeight: FontWeight.w700),
      ),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Card(
               color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.location_city,color: ksecondcolor,),
                title: const Text('Governorate',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700),),
                subtitle: Text(widget.tour.governorate ?? 'No governorate',style: TextStyle(color: kmaincolor)),
              ),
            ),
            Card(
               color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.group,color: ksecondcolor),
                title: Text('Group Size',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700)),
                subtitle: Text(widget.tour.groupSize ?? 'No group size',style: TextStyle(color: kmaincolor)),
              ),
            ),
            Card(
               color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.date_range,color: ksecondcolor),
                title: Text('Start Date',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700)),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(widget.tour.startDate!.toLocal()) ?? 'No start date',style: TextStyle(color: kmaincolor)),
              ),
            ),
            Card(
               color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.date_range,color: ksecondcolor),
                title: Text('End Date',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700)),
                subtitle: Text(DateFormat('dd/MM/yyyy').format(widget.tour.endDate!.toLocal())?? 'No end date',style: TextStyle(color: kmaincolor)),
              ),
            ),
            Card(
               color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.comment,color: ksecondcolor),
                title: Text('Comment for Guide',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700)),
                subtitle: Text(widget.tour.commentForGuide ?? 'No comment',style: TextStyle(color: kmaincolor)),
              ),
            ),
            Card(
               color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.flag,color: ksecondcolor),
                title: Text('Status',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700)),
                subtitle: Text(widget.tour.status ?? 'No status',style: TextStyle(color: kmaincolor)),
              ),
            ),
            Card(
               color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.payment,color: ksecondcolor),
                title: Text('Payment Status',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700)),
                subtitle: Text(widget.tour.paymentStatus ?? 'No payment status',style: TextStyle(color: kmaincolor)),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.tour.landmarks?.length ?? 0,
              itemBuilder: (context, index) {
                final landmark = widget.tour.landmarks![index];
                return Card(
                   color: ksecondcolor2,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(Icons.location_on,color: ksecondcolor),
                    title: Text(landmark.name ?? 'No name',style: TextStyle(color: kmaincolor,fontWeight: FontWeight.w700)),
                    subtitle: Text(landmark.category?.name ?? 'No category',style: TextStyle(color: kmaincolor)),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal:26, vertical: 11),
            backgroundColor:  kmaincolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),),
                onPressed: () async {
                  print('Cancel tour button pressed');
                  showDialog(
                    context: context,
                    builder: (context) => Center(child: CircularProgressIndicator()),
                  );
                  await cancelTour(context, widget.tour.id ?? '');
                  print('Tour cancelled successfully');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tour cancelled successfully')),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyOrdersPage(),
                    ),
                  );
                },
                child: Text('Cancel Tour',style:TextStyle(color: kbackgroundcolor,fontWeight: FontWeight.w700) ,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
