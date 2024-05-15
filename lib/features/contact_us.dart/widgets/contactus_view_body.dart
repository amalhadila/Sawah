import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/widgets.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:graduation/core/widgets/appbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactusViewBody extends StatelessWidget {
  ContactusViewBody({super.key});
  final Uri _url = Uri.parse('mailto:Sawah1010@gmail.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Container(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'You can E-mail us on ',
                style: Textstyle.textStyle16,
              ),
              SizedBox(height: 30),
              InkWell(
                onTap: _launchUrl,
                child: Text(
                  'Sawah1010@gmail.com',
                  style:
                      Textstyle.textStyle16.copyWith(color: Color(0xff00A2D5)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
