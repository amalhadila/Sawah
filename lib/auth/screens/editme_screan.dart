import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mime/mime.dart';

import '../../constants.dart';
import '../cach/cach_helper.dart';
import '../core_login/api/end_point.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  File? _profileImage;
  bool _isLoading = false;
  final Dio _dio = Dio();

  Future<void> _pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      final mimeType = lookupMimeType(image.path);
      if (mimeType != null && mimeType.startsWith('image/')) {
        setState(() {
          _profileImage = File(image.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please upload only images.')),
        );
      }
    }
  }

  Future<void> _updateProfile() async {
    setState(() {
      _isLoading = true;
    });

    final url = 'https://sawahonline.com/api/v1/users/updateMe';

    FormData formData = FormData.fromMap({
      'name': _nameController.text,
      if (_profileImage != null)
        'photo': await MultipartFile.fromFile(_profileImage!.path),
    });

    try {
      final response = await _dio.patch(
        url,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheHelper().getData(key: apikey.token)}',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );
      } else {
        print('Failed to update profile');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    } catch (e) {
      String errorMessage = 'An error happened';
      if (e is DioError) {
        if (e.response != null) {
          errorMessage = e.response?.data.toString() ?? 'Unknown error';
        } else {
          errorMessage = e.message.toString();
        }
      }
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error happened: $errorMessage')),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kmaincolor,
        title: const Text(
          'Update Profile',
          style: TextStyle(color: kbackgroundcolor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: _profileImage == null
                    ? const AssetImage('assets/default_avatar.png')
                    : FileImage(_profileImage!) as ImageProvider,
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(kbackgroundcolor),
              //   ),
              //   onPressed: _pickImage,
              //   child: const Text('Upload Image',style: TextStyle(color: kbackgroundcolor),),
              // ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(kmaincolor),
                      ),
                      onPressed: _updateProfile,
                      child: const Text('Update',style: TextStyle(color: kbackgroundcolor),),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
