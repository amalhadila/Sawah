import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/home/pres/views/widget/featuredlistview.dart';
import 'package:graduation/core/utils/slider.dart';

class homeviewbody extends StatefulWidget {
  const homeviewbody({super.key});

  @override
  State<homeviewbody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<homeviewbody> {
  bool _animate = true;

  @override
  void initState() {
    super.initState();
    _startAnimationLoop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ImageSlider(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .028),
            TweenAnimationBuilder(
              curve: Curves.linear,
              duration: Duration(seconds:3),
             tween: ColorTween(
                begin: _animate ? kbackgroundcolor : accentColor1,
                end: _animate ? accentColor1 : kbackgroundcolor,
              ),

              builder: (context, value, child) => Text(
                'home.welcome'.tr(),
                style: TextStyle(
                  color: value,
                  fontSize: 32,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Pacifico',
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .03,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 2),
                  child: Text(
                    'home.mostVisited'.tr(),
                    style: TextStyle(
                      color: kmaincolor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .015,
                ),
                feturedcustemlist(),
              ],
            )
          ],
        ),
      ),
    );
  }
 void _startAnimationLoop() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _animate = !_animate;
        });
        _startAnimationLoop();
      }
    });
  }
}
