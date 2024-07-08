import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:sawah/features/create_tour.dart/presentation/model/get_my_requests_model.dart';
import 'package:sawah/features/create_tour.dart/presentation/views/widgets/my%20orders.dart';
import 'package:intl/intl.dart';

Future cancelTour(BuildContext context, String tourId) async {
  final Dio _dio = Dio();
  try {
    print('Cancel tour request sent');
    var response = await _dio.patch(
      options: Options(
        headers: {
          'Authorization': 'Bearer ${Token}',
        },
      ),
      'https://sawahonline.com/api/v1/customizedTour/$tourId/cancel',
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
        title: const Text(
          'Tour Details',
          style: Textstyle.textStyle21,
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
                leading: const Icon(
                  Icons.location_city,
                  color: ksecondcolor,
                ),
                title: const Text(
                  'Governorate',
                  style:
                      Textstyle.textStyle16,
                ),
                subtitle: Text(widget.tour.governorate ?? 'No governorate',
                    style: Textstyle.textStyle13),
              ),
            ),
            Card(
              color: ksecondcolor2,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.group, color: ksecondcolor),
                title: const Text('Group Size',
                    style: Textstyle.textStyle16),
                subtitle: Text(widget.tour.groupSize ?? 'No group size',
                    style: Textstyle.textStyle13),
              ),
            ),
            Card(
              color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.date_range, color: ksecondcolor),
                title: Text('Start Date',
                    style: Textstyle.textStyle16),
                subtitle: Text(
                    DateFormat('dd/MM/yyyy')
                            .format(widget.tour.startDate!.toLocal()) ??
                        'No start date',
                    style: Textstyle.textStyle13),
              ),
            ),
            Card(
              color: ksecondcolor2,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.date_range, color: ksecondcolor),
                title: Text('End Date',
                    style: Textstyle.textStyle16),
                subtitle: Text(
                    DateFormat('dd/MM/yyyy')
                            .format(widget.tour.endDate!.toLocal()) ??
                        'No end date',
                    style: Textstyle.textStyle13),
              ),
            ),
            Card(
              color: ksecondcolor2,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.comment, color: ksecondcolor),
                title: const Text('Comment for Guide',
                    style: Textstyle.textStyle16),
                subtitle: Text(widget.tour.commentForGuide ?? 'No comment',
                    style: Textstyle.textStyle13),
              ),
            ),
            Card(
              color: ksecondcolor2,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: const Icon(Icons.flag, color: ksecondcolor),
                title: const Text('Status',
                    style: Textstyle.textStyle16),
                subtitle: Text(widget.tour.status ?? 'No status',
                    style: Textstyle.textStyle13),
              ),
            ),
            Card(
              color: ksecondcolor2,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(Icons.payment, color: ksecondcolor),
                title: Text('Payment Status',
                    style: Textstyle.textStyle16),
                subtitle: Text(widget.tour.paymentStatus ?? 'No payment status',
                    style: Textstyle.textStyle13),
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
                    leading: Icon(Icons.location_on, color: ksecondcolor),
                    title: Text(landmark.name ?? 'No name',
                        style: Textstyle.textStyle16),
                    subtitle: Text(landmark.category?.name ?? 'No category',
                        style: Textstyle.textStyle13),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 26, vertical: 11),
                  backgroundColor: kmaincolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  print('Cancel tour button pressed');
                  showDialog(
                    context: context,
                    builder: (context) =>
                        Center(child: CircularProgressIndicator()),
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
                child: Text(
                  'Cancel Tour',
                  style: Textstyle.textStyle16.copyWith( color: kbackgroundcolor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
