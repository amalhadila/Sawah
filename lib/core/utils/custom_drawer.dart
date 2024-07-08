import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sawah/constants.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double drawerHeight = MediaQuery.of(context).size.height;
    double headerHeight = drawerHeight * 0.34;

    return Drawer(
      child: ListView(
        dragStartBehavior: DragStartBehavior.start,
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: headerHeight,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/be563d7bfaefe67696fab70f7524d5b1.gif',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context).push('/profilesrean'),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/egypt-pyramid_8330589.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .04,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  if (EasyLocalization.of(context)!.currentLocale ==
                      const Locale('en')) {
                    EasyLocalization.of(context)!.setLocale(const Locale('ar'));
                  } else {
                    EasyLocalization.of(context)!.setLocale(const Locale('en'));
                  }
                },
                child: _buildDrawerItem(
                  icon: Icons.language,
                  text: 'drawer.language'.tr(),
                ),
              ),
              _buildDrawerItem(
                icon: Icons.share,
                text: 'drawer.share'.tr(),
                onTap: () {
                  // Add functionality to share the app
                },
              ),
              _buildDrawerItem(
                icon: Icons.star,
                text: 'drawer.rate'.tr(),
                onTap: () {
                  // Add functionality to rate the app
                },
              ),
              InkWell(
                onTap: () => GoRouter.of(context).push('/contactus'),
                child: _buildDrawerItem(
                  icon: Icons.phone,
                  text: 'drawer.contact'.tr(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    Function()? onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: kmaincolor,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 18,
          color: kmaincolor,
          fontWeight: FontWeight.w900,
          letterSpacing: 0,
        ),
      ),
      onTap: onTap,
    );
  }
}
