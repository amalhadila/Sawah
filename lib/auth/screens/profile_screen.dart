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
      body: Column(
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
                  'Profile',
                  textAlign: TextAlign.center,
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
              child: BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is GetUserLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetUserFailure) {
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  } else if (state is GetUserSuccess) {
                    final user = state.user;
                    return ListView(
                      children: [
                        SizedBox(
                          width: 50,
                          height: MediaQuery.of(context).size.height * .227,
                          child: context.read<UserCubit>().profilepic == null
                              ? CircleAvatar(
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage: NetworkImage(user.data.photo ?? 'assets/default_avatar.png'),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 5,
                                        right: 75,
                                        child: GestureDetector(
                                          onTap: () async {
                                            XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
                                            if (image != null) {
                                              context.read<UserCubit>().uploadprofilepict(image);
                                            }
                                          },
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.blue.shade400,
                                              border: Border.all(color: Colors.white, width: 3),
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            child: const Icon(
                                              Icons.camera_alt_sharp,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : CircleAvatar(
                                  backgroundImage: FileImage(File(context.read<UserCubit>().profilepic!.path)),
                                ),
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            ProfileMenu(
                              text: user.data.name ?? 'name',
                              icon: "assets/cameraa.svg",
                              press: () => {},
                            ),
                            ProfileMenu(
                              text: user.data.email ?? 'email',
                              icon: "assets/cameraa.svg",
                              press: () => {},
                            ),
                            ProfileMenu(
                              text: 'wishlist',
                              icon: "assets/cameraa.svg",
                              press: () => {},
                            ),
                            ProfileMenu(
                              text: 'Interests',
                              icon: "assets/cameraa.svg",
                              press: () => {},
                            ),
                            ProfileMenu(
                              text: 'logout',
                              icon: "assets/cameraa.svg",
                              press: () => {},
                            ),
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

  final String text, icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Color(0xFFFF7643),
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: const Color(0xFFF5F6F9),
        ),
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: Color(0xFFFF7643),
              width: 22,
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(text)),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
    required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(image),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.orange),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
