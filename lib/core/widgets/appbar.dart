import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/widgets/custom_textfield.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(45.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: abarcolor,
      elevation: 1,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: MediaQuery.of(context).size.height*.01),
            child: CustomTextField(),
          ),
          IconButton(
            icon: const Icon(Icons.language, color: Colors.white),
            onPressed: () {
              if (EasyLocalization.of(context)!.currentLocale ==
                  const Locale('en')) {
                EasyLocalization.of(context)!.setLocale(const Locale('ar'));
              } else {
                EasyLocalization.of(context)!.setLocale(const Locale('en'));
              }
              // Add your world icon functionality here
            },
          ),
        ],
      ),
    );
  }
}
