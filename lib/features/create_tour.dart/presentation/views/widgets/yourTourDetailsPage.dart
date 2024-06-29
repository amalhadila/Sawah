import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_my_requests_model.dart';

Future cancelTour(BuildContext context, String tourId) async {
  final Dio _dio = Dio();
  try {
    print('Cancel tour request sent');
    var response = await _dio.patch(
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
          },
        ),
        'http://192.168.1.6:8000/api/v1/customizedTour/$tourId/cancel');
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

class yourTourDetailsPage extends StatefulWidget {
  final GetMyRequestsModel tour;

  yourTourDetailsPage({required this.tour});

  @override
  _yourTourDetailsPageState createState() => _yourTourDetailsPageState();
}

class _yourTourDetailsPageState extends State<yourTourDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tour Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('User Name: ${widget.tour.user?.name?? 'No user name'}'),
            Text('Governorate: ${widget.tour.governorate?? 'No governorate'}'),
            Text('Group Size: ${widget.tour.groupSize?? ''}'),
            Text('Landmark: ${widget.tour.landmarks?[0].name?? ''}'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  print('Cancel tour button pressed');
                  showDialog(
                    context: context,
                    builder: (context) => Center(child: CircularProgressIndicator()),
                  );
                  await cancelTour(context, widget.tour.id?? '');
                  print('Tour cancelled successfully');
                  Navigator.pop(context);
                  Navigator.pop(context);
                } catch (e) {
                  print('Error cancelling tour: $e');
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Operation Failed"),
                      content: Text("An error happened $e, please try again"),
                    ),
                  );
                }
              },
              child: Text('Cancel Tour'),
            ),
          ],
        ),
      ),
    );
  }
}