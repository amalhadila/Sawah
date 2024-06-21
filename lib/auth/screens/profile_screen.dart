import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/auth/cubit/user_cubit.dart';
import 'package:graduation/auth/cubit/user_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Text(
                    textAlign: TextAlign.center,
                    'Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is GetUserLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetUserFailure) {
                      return Center(child: Text('Error: ${state.errorMessage}'));
                    } else if (state is GetUserSuccess) {
                      final user = state.user;
                      return ListView(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * .02),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .227,
                            width: 115,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(user.data.photo ?? 'https://www.google.com/imgres?q=review%20with%20rating%20ui&imgurl=https%3A%2F%2Fassets-global.website-files.com%2F5e3de80322b300854230f11f%2F5ef96150f0c354686cb6128f_reviews-1.jpg&imgrefurl=https%3A%2F%2Fwww.niceverynice.com%2Fcomponents%2Fproduct-reviews-with-rating-and-detailed-description&docid=vzecAQo7wQnpBM&tbnid=01MXXxiyLsfzeM&vet=12ahUKEwiap_jh4MeGAxUNTqQEHa2yHukQM3oECGEQAA..i&w=2880&h=2952&hcb=2&ved=2ahUKEwiap_jh4MeGAxUNTqQEHa2yHukQM3oECGEQAA'),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 72,
                                  child: RawMaterialButton(
                                    onPressed: () {},
                                    elevation: 2.0,
                                    fillColor: Color(0xFFF5F6F9),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.orange,
                                    ),
                                    padding: EdgeInsets.all(10.0),
                                    shape: CircleBorder(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(user.data.name ?? 'unde', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                              Text(user.data.email ?? 'email', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                            ],
                          ),
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),
                          const Text('Interests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Wrap(
                            spacing: 8.0,
                            children: user.data.interests.map((interest) => Chip(label: Text(interest))).toList(),
                          ),
                          const SizedBox(height: 32),
                          const Divider(),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.logout, color: Colors.black),
                              const SizedBox(width: 8),
                              TextButton(
                                onPressed: () {
                                  // Add your logout logic here
                                },
                                child: const Text(
                                  'Log out',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),Container()
                            ],
                          ),
                        ],
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
