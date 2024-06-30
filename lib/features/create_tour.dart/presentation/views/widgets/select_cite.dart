import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_all_governs_model.dart';
import 'package:graduation/features/create_tour.dart/guide_requests.dart';
import 'package:dio/dio.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/select_landmarks.dart';

class CitySelectionScreen extends StatefulWidget {
  @override
  State<CitySelectionScreen> createState() => _CitySelectionScreenState();
}

class _CitySelectionScreenState extends State<CitySelectionScreen> {
  String? selectedCity;

  Future<GetAllGovernsModel> getAllGoverns(BuildContext context) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
        'http://192.168.1.4:8000/api/v1/customizedTour/governorates',
        options: Options(
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjVjOGExZjI5MmY4ZmI4MTRiNTZmYTE4NCIsImlhdCI6MTcxOTM2NzE5MCwiZXhwIjoxNzI3MTQzMTkwfQ.tS7RqEwaramU40EOYYOmXhfvRmNGuYrKq9DD21RK7_E',
          },
        ),
      );
      GetAllGovernsModel getAllGovernsModel =
          GetAllGovernsModel.fromJson(response.data);
      return getAllGovernsModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
      return GetAllGovernsModel(status: "error", results: 0, data: Data(governorates: []));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text(
          'Choose the city',
         style: TextStyle(color: kmaincolor,fontSize: 19,fontWeight: FontWeight.w700),),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            
            Expanded(
              child: FutureBuilder<GetAllGovernsModel>(
                future: getAllGoverns(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.data.governorates.isEmpty) {
                    return Center(child: Text('No cities found'));
                  } else {
                    final governorates = snapshot.data!.data.governorates;
                    return ListView.builder(
                      itemCount: governorates.length,
                      itemBuilder: (context, index) {
                        final city = governorates[index];
                        final isSelected = selectedCity == city;
                        return ListTile(
                          title: Text(city,
                              style: TextStyle(fontWeight: FontWeight.w600)),
                          trailing: isSelected
                              ? Icon(Icons.check, color: accentColor3)
                              : null,
                          onTap: () {
                            setState(() {
                              selectedCity = city;
                            });
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80),
              child: ElevatedButton(
                onPressed: selectedCity != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LandmarkSelectionScreen(selectedGovernorate: selectedCity!)),
                        );
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please, select a city')));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kmaincolor,
                  minimumSize: Size.fromHeight(48),
                ),
                child: const Text('Next',
                    style: TextStyle(
                        color: kbackgroundcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
