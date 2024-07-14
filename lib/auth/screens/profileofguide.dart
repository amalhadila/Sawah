import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sawah/features/bottom_app_bar/bottom_app_bar.dart';

import '../../constants.dart';
import '../../core/utils/custom_drawer.dart';
import '../../firebase/firedatabase.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';
import 'editguideinfo.dart';
import 'editme_screan.dart';
import 'profile_screen.dart';

class ProfileCard extends StatefulWidget {
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kbackgroundcolor),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavigation()));
          },
        ),
        backgroundColor: kmaincolor,
        title: Text(
          'Profile',
          style: TextStyle(color: kbackgroundcolor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push('/ChatHomeScreen');
            },
            icon: const Icon(
              Icons.chat,
              color: kbackgroundcolor,
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: BlocConsumer<UserCubit, UserState>(
            listener: (context, state) {
              if (state is UserLoggedOut) {
                GoRouter.of(context)
                    .push('/sign'); // Redirect to sign-in screen
              } else if (state is UserLogoutFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Logout failed: ${state.errorMessage}')),
                );
              }
            },
            builder: (context, state) {
              if (state is GetUserLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is GetUserFailure) {
                return Center(child: Text('Error: ${state.errorMessage}'));
              } else if (state is GetUserSuccess) {
                final user = state.user;
                return Column(
                  children: [
                    SizedBox(height: 20.0),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Profile Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                user.data.photo ?? 'assets/default_avatar.png',
                                height: 80.0,
                                width: 80.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            // Profile Information
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user.data.name,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ), 
                                      GestureDetector(
                                           onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateProfileScreen()));
                                        },
                                        child: Text(
                                          'edit',
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: kmaincolor
                                          ),
                                        ),
                                      ), 
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ), Text(
                                        user.data.email ,
                                          
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 20.0),
                                      SizedBox(width: 4.0),
                                      SizedBox(width: 4.0),
                                      Text(
                                        user.data.rating != null
                                            ? user.data.rating.toString()
                                            : '0',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      Text(
                                        '(${user.data.ratingsQuantity ?? 0})',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                        height: 16.0), // Added space between the two containers
                    Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'General information',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen()));
                                },
                                child: Text(
                                  'edit',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: kmaincolor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Cities',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Wrap(
                            spacing: 8.0,
                            children: user.data.governorates != null &&
                                    user.data.governorates!.isNotEmpty
                                ? user.data.governorates!
                                    .map((city) => _buildChip(city))
                                    .toList()
                                : [_buildChip('No cities available')],
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Languages',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Wrap(
                            spacing: 8.0,
                            children: user.data.languages != null
                                ? user.data.languages!
                                    .map((language) => _buildChip(language))
                                    .toList()
                                : [],
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'About',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          TextField(
                            decoration: InputDecoration(
                              hintText: user.data.bio ??
                                  '',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                            ),
                            maxLines: 4,
                          ),
                        ],
                      ),
                    ),
                    ProfileMenu(
                      text: 'Logout',
                      icon: Icon(Icons.logout, color: Colors.black),
                      press: () async {
                        await FireData().deleteUser();
                        context.read<UserCubit>().logout();
                      },
                    ),
                  ],
                );
              } else {
                return Center(child: Text('THERE are a proplem'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Chip(
      backgroundColor: kmaincolor,
      label: Text(
        label,
        style: TextStyle(color: kbackgroundcolor),
      ),
    );
  }
}
