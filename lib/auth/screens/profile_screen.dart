import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sawah/auth/cubit/user_cubit.dart';
import 'package:sawah/auth/cubit/user_state.dart';
import 'package:sawah/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';

import '../../firebase/firedatabase.dart';

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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 25.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: kmaincolor,
                    size: 22,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Text(
                  'Profile',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kmaincolor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    GoRouter.of(context).push('/ChatHomeScreen');
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: kmaincolor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserLoggedOut) {
                    GoRouter.of(context).push('/sign'); // Redirect to sign-in screen
                  } else if (state is UserLogoutFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Logout failed: ${state.errorMessage}')),
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
                    return ListView(
                      children: [
                        context.read<UserCubit>().profilepic == null
                            ? CircleAvatar(
                              radius: 60,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage: NetworkImage(
                                    user.data.photo ??
                                        'assets/default_avatar.png',),
                                // هنا تم إزالة الأيقونة
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(File(context
                                    .read<UserCubit>()
                                    .profilepic!
                                    .path)),
                              ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            ProfileMenu(
                              text: user.data.name ?? 'name',
                              icon: const Icon(Icons.person, color: ksecondcolor),
                              press: () => {GoRouter.of(context).push('/update')},
                            ),
                            ProfileMenu(
                              text: user.data.email ?? 'email',
                              icon: const Icon(Icons.email, color: ksecondcolor),
                              press: () => {},
                            ),
                            ProfileMenu(
                              text: 'wishlist',
                              icon: const Icon(Icons.favorite, color: ksecondcolor),
                              press: () => {GoRouter.of(context).push('/wishlist')},
                            ),
                            ProfileMenu(
                              text: 'my tours',
                              icon: const Icon(Icons.favorite, color: ksecondcolor),
                              press: () => {GoRouter.of(context).push('/Bookingtours')},
                            ),
                            ProfileMenu(
                              text: 'logout',
                              icon: Icon(Icons.logout, color: ksecondcolor),
                              press: () async {
                                await FireData().deleteUser();
                                context.read<UserCubit>().logout();
                              },
                            ),
                          ],
                        )
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
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kmaincolor,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
