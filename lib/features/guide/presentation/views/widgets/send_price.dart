import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/features/guide/presentation/views/widgets/tours_list.dart';
import '../../../../../auth/cach/cach_helper.dart';
import '../../../../../auth/core_login/api/end_point.dart';
import '../../../../bottom_app_bar/bottom_app_bar.dart';

class SendPriceScreen extends StatelessWidget {
  final String tourId;

  const SendPriceScreen({super.key, required this.tourId});

  Future<void> respondToTourRequest(
      BuildContext context, String tourId, String price) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.patch(
        'https://sawahonline.com/api/v1/customizedTour/respond/$tourId',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}',
          },
        ),
        data: {"price": int.parse(price)}, // Ensure price is sent as an integer
      );
      print('Response: ${response.data}');
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Success"),
          content: Text("Price sent successfully"),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigation()),
      );
    } catch (e) {
      print(e.toString());
      // Extract more information from DioError
      String? errorMessage = 'An error occurred';
      if (e is DioError) {
        if (e.response != null) {
          errorMessage = e.response?.data.toString() ?? 'Unknown error';
        } else {
          errorMessage = e.message;
        }
      }
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened: $errorMessage, please try again"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController priceController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Send Price', style: TextStyle(color: Colors.white)),
        backgroundColor: kmaincolor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              TextField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: 'Enter Price',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () async {
                    String price = priceController.text;
                    print('Price: $price');
                    await respondToTourRequest(context, tourId, price);
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                        color: kbackgroundcolor, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kmaincolor,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
