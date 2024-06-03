import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionScreenViewBody extends StatelessWidget {
  IntroductionScreenViewBody({super.key});

  final List<PageViewModel> pages = [
    PageViewModel(
      decoration: const PageDecoration(
          pageColor: abarcolor, titleTextStyle: Textstyle.textStyle25),
      image: Image.asset(
        'assets/egypt-pyramid_8330589.png',
        width: 230,
        height: 230,
        fit: BoxFit.fill,
      ),
      title: 'onBoarding.learnMore'.tr(),
      body: '',
    ),
    PageViewModel(
      decoration: const PageDecoration(
          pageColor: abarcolor, titleTextStyle: Textstyle.textStyle25),
      image: Image.asset(
        'assets/qr-scan_11815469.png',
        width: 230,
        height: 230,
        fit: BoxFit.fill,
      ),
      title: 'onBoarding.scan'.tr(),
      body: '',
    ),
    PageViewModel(
      decoration: const PageDecoration(
          pageColor: abarcolor, titleTextStyle: Textstyle.textStyle25),
      image: Image.asset(
        'assets/sphinx_760052.png',
        width: 230,
        height: 230,
        fit: BoxFit.fill,
      ),
      title: 'onBoarding.enjoy'.tr(),
      body: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: abarcolor,
      appBar: AppBar(
        title: const Text(
          'SawaH',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontFamily: 'Pacifico',
          ),
        ),
        centerTitle: true,
        backgroundColor: abarcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 80, 12, 12),
        child: IntroductionScreen(
          globalBackgroundColor: abarcolor,
          pages: pages,
          dotsDecorator: const DotsDecorator(
            size: Size(15, 15),
            color: Colors.blue,
            activeSize: Size.square(20),
            activeColor: Colors.white,
          ),
          showDoneButton: true,
          done: Text(
            'onBoarding.done'.tr(),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          showSkipButton: true,
          skip: Text(
            'onBoarding.skip'.tr(),
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          showNextButton: true,
          next: const Icon(
            Icons.arrow_forward,
            size: 25,
          ),
          onDone: () => onDone(context),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  void onDone(context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('ON_BOARDING', false);
    GoRouter.of(context).push('/');
  }
}
