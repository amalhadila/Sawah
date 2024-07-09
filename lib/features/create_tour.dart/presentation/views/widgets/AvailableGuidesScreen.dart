import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sawah/features/create_tour.dart/presentation/model/get_avaiabled_guides_model.dart';

class AvailableGuidesScreen extends StatelessWidget {
  final String tourId;

  const AvailableGuidesScreen({Key? key, required this.tourId}) : super(key: key);

  Future<List<GetAvailableGuidesModel>> getAvailableGuides(String tourId) async {
  final Dio _dio = Dio();
  try {
    var response = await _dio.get(
      'https://sawahonline.com/api/v1/customizedTour/$tourId/browse-guides',
      options: Options(
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
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
    throw e; // Rethrow the exception to handle it further if needed
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Guides'),
      ),
      body: FutureBuilder<List<GetAvailableGuidesModel>>(
        future: getAvailableGuides(tourId),
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
                  onTap: () {
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
