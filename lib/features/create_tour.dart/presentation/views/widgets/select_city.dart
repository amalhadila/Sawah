import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_all_governs_model.dart';
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
            'Authorization': 'Bearer ${Token}',
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
      return GetAllGovernsModel(
          status: "error", results: 0, data: Data(governorates: []));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title:const Text(
          'Choose the city',
          style: Textstyle.textStyle21,
        ),
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
                  } else if (!snapshot.hasData ||
                      snapshot.data!.data.governorates.isEmpty) {
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
                              style:Textstyle.textStyle16.copyWith(color:neutralColor3 ),),
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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80),
              child: ElevatedButton(
                onPressed: selectedCity != null
                    ? () {
                      print(selectedCity);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandmarkSelectionScreen(
                                  selectedGovernorate: selectedCity!)),
                        );
                      }
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please, select a city')));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kmaincolor,
                  minimumSize: Size.fromHeight(48),
                ),
                child:  Text('Next',
                    style: Textstyle.textStyle16.copyWith( color: kbackgroundcolor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
