import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/core/utils/app_router.dart';

import 'package:graduation/core/utils/assets.dart';
import 'package:graduation/core/utils/style.dart';

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
          height: 4,
        ),
        Text(
          'welcome to egypt ...',
          textAlign: TextAlign.center,
          style: Textstyle.textStyle12,
        )
      ],
    ));
  }
  
}
// }
