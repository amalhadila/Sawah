import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../cach/cach_helper.dart';
import '../core_login/api/end_point.dart';
import 'profileofguide.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  List<String> _cities = [
    'Cairo',
    'Giza',
    'Alexandria',
    'Aswan',
    'Luxor',
    'Sohag',
    'South Sinai'
  ];
  List<String> _languages = ['Arabic', 'Italian', 'French','Chinese','Greek','Turkish','Greek'];

  List<String> _selectedCities = [];
  List<String> _selectedLanguages = [];
  TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kbackgroundcolor),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfileCard()));
          },
        ),
        backgroundColor: kmaincolor,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: kbackgroundcolor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Select City',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () => _showCityDialog(),
                    style: ButtonStyle(
                      // ignore: deprecated_member_use
                      backgroundColor: MaterialStateProperty.all(kmaincolor),
                      foregroundColor: WidgetStateProperty.all(kbackgroundcolor),
                    ),
                    child: Text(
                        _selectedCities.isEmpty
                            ? 'Choose City'
                            : _selectedCities.join(', '),
                        style: TextStyle(color: kbackgroundcolor)),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Select Language',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () => _showLanguageDialog(),
                    style: ButtonStyle(
                      // ignore: deprecated_member_use
                      backgroundColor: MaterialStateProperty.all(kmaincolor),
                      foregroundColor: WidgetStateProperty.all(kbackgroundcolor),
                    ),
                    child: Text(
                      _selectedLanguages.isEmpty
                          ? 'Choose Language'
                          : _selectedLanguages.join(', '),
                      style: TextStyle(color: kbackgroundcolor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              SizedBox(height: 16.0),
              Text(
                'Bio',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _bioController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Tell tourists about yourself',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    // ignore: deprecated_member_use
                    backgroundColor: MaterialStateProperty.all(kmaincolor),
                    foregroundColor: WidgetStateProperty.all(kbackgroundcolor),
                  ),
                  onPressed: () async {
                    try {
                      String token = CacheHelper().getData(key: apikey.token);
                      if (token == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Token is null')),
                        );
                        return;
                      }
            
                      FormData formData = FormData.fromMap({
                        'newGovernorate': _selectedCities.join(','),
                        'newLanguage': _selectedLanguages.join(','),
                        'bio': _bioController.text,
                      });
            
                      var dio = Dio();
                      dio.options.headers['Authorization'] = 'Bearer $token';
                      dio.options.contentType = 'multipart/form-data';
            
                      print('Sending data: ${formData.fields}'); // Debug print
            
                      var response = await dio.patch(
                          'https://sawahonline.com/api/v1/users/updateMe',
                          data: formData);
            
                      if (response.statusCode == 200) {
                        print('Profile updated successfully');
                        print(response);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Profile updated successfully')),
                        );
                      } else {
                        print('Failed to update profile: ${response.statusCode}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Failed to update profile: ${response.statusCode}')),
                        );
                      }
                    } catch (e) {
                      print('Error sending data: $e');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: $e')),
                      );
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCityDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select City'),
              content: Container(
                width: double.minPositive,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _cities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      title: Text(_cities[index]),
                      value: _selectedCities.contains(_cities[index]),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedCities.add(_cities[index]);
                          } else {
                            _selectedCities.remove(_cities[index]);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('CONFIRM'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      setState(
          () {}); // Update the main widget's state after closing the dialog
    });
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Select Language'),
              content: Container(
                width: double.minPositive,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _languages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CheckboxListTile(
                      title: Text(_languages[index]),
                      value: _selectedLanguages.contains(_languages[index]),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            _selectedLanguages.add(_languages[index]);
                          } else {
                            _selectedLanguages.remove(_languages[index]);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('CANCEL'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text('CONFIRM'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      setState(
          () {}); // Update the main widget's state after closing the dialog
    });
  }
}
