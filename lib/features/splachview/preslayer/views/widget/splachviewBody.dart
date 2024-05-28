import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/utils/assets.dart';

class splachviewbody extends StatefulWidget {
  const splachviewbody({super.key});

  @override
  State<splachviewbody> createState() => _splachviewbodyState();
}

class _splachviewbodyState extends State<splachviewbody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;
  @override
  void initState() {
    super.initState();
    initSlidingAnimation();

    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();

    animationController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * .4,
            child: Image.asset(
              AssetsData.logo,
            )),
        SizedBox(
          height: 8,
        ),
        // SlidingText(slidingAnimation: slidingAnimation),
      ],
    ));
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    slidingAnimation =
        Tween<Offset>(begin: const Offset(0, 4), end: Offset.zero)
            .animate(animationController);

    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        GoRouter.of(context).push('/sign');
      },
    );
  }
}
