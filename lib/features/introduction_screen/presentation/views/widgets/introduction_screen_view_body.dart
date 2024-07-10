import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreenViewBody extends StatelessWidget {
  IntroductionScreenViewBody({super.key});

  final List<PageViewModel> pages = [
    PageViewModel(
      decoration: const PageDecoration(
          pageColor: kbackgroundcolor, bodyTextStyle: Textstyle.textStyle16),
      image: Image.asset(
        'assets/Usability testing (1).gif',
        width: 330,
        height: 400,
        fit: BoxFit.fill,
      ),
      title: '',
      bodyWidget: Text(
          'Welcome aboard! Dive into a world of wonder as you explore detailed info on tourist hotspots. ',
          style: Textstyle.textStyle16.copyWith(color: neutralColor3)),
    ),
    PageViewModel(
      decoration: const PageDecoration(
          pageColor: kbackgroundcolor, bodyTextStyle: Textstyle.textStyle16),
      image: Image.asset(
        'assets/Date picker.gif',
        width: 330,
        height: 400,
        fit: BoxFit.fill,
      ),
      title: '',
      bodyWidget: Text(
          'Your adventure, your way! Pick from expertly curated tours or design your own unique journey tailored just for you.',
          style: Textstyle.textStyle16.copyWith(color: neutralColor3)),
    ),
    PageViewModel(
      decoration: const PageDecoration(
          pageColor: kbackgroundcolor, bodyTextStyle: Textstyle.textStyle16),
      image: Image.asset(
        'assets/Tour guide (2).gif',
        width: 330,
        height: 400,
        fit: BoxFit.fill,
      ),
      title: '',
      bodyWidget: Text(
          'Need a hand? Chat with our expert guides for tailored tips and guidance to make your trip unforgettable.',
          style: Textstyle.textStyle16.copyWith(color: neutralColor3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
        child: IntroductionScreen(
          globalBackgroundColor: kbackgroundcolor,
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(15, 15),
            color: ksecondcolor,
            activeSize: Size.square(20),
            activeColor: kmaincolor,
          ),
          showDoneButton: true,
          done: Text(
            'onBoarding.done'.tr(),
            style: TextStyle(
                fontSize: 20, color: kmaincolor, fontWeight: FontWeight.w700),
          ),
          showSkipButton: true,
          skip: Text(
            'onBoarding.skip'.tr(),
            style: TextStyle(
                fontSize: 20, color: kmaincolor, fontWeight: FontWeight.w700),
          ),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 25,
          ),
          onDone: () => onDone(context),
          curve: Curves.linear,
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    GoRouter.of(context).push('/sign');
  }
}
