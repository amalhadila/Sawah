import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sawah/features/create_tour.dart/presentation/model/get_avaiabled_guides_model.dart';

import '../../../../../auth/cach/cach_helper.dart';
import '../../../../../auth/core_login/api/end_point.dart';
import '../../../../../constants.dart';

class AvailableGuidesScreen extends StatefulWidget {
  final String tourId;

  const AvailableGuidesScreen({Key? key, required this.tourId}) : super(key: key);

  @override
  _AvailableGuidesScreenState createState() => _AvailableGuidesScreenState();
}

class _AvailableGuidesScreenState extends State<AvailableGuidesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<GetAvailableGuidesModel>> getAvailableGuides(String tourId) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'https://sawahonline.com/api/v1/customizedTour/$tourId/browse-guides',
        options: Options(
          headers: {
            'Authorization':
                'Bearer ${CacheHelper().getData(key: apikey.token)}',
          },
        ),
      );

      dynamic responseData = response.data;
      print(responseData);

      List<GetAvailableGuidesModel> guides = [];
      if (responseData is List) {
        guides = responseData
            .map((json) => GetAvailableGuidesModel.fromJson(json))
            .toList();
      } else if (responseData is Map<String, dynamic>) {
        guides.add(GetAvailableGuidesModel.fromJson(responseData));
      }

      return guides;
    } catch (e) {
      if (_scaffoldKey.currentContext != null) {
        _showErrorDialog(_scaffoldKey.currentContext!, 'An error occurred: ${e.toString()}');
      }
      await Future.delayed(Duration(seconds: 3)); // Delay before retrying
      return await getAvailableGuides(tourId); // Retry the request
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Available Guides'),
      ),
      body: FutureBuilder<List<GetAvailableGuidesModel>>(
        future: getAvailableGuides(widget.tourId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No guides available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var guide = snapshot.data![index];
                return ListTile(
                  title: Text(guide.name ?? 'name'),
                  subtitle: Text('Rating: ${guide.rating ?? 0}'),
                  leading: guide.photo != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(guide.photo!),
                        )
                      : null,
                  onTap: () {},
                );
              },
            );
          }
        },
      ),
    );
  }
}
