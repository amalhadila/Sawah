import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation/features/home/pres/views/widget/featuredlistview.dart';
import 'package:graduation/core/utils/slider.dart';

class homeviewbody extends StatelessWidget {
  const homeviewbody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: ImageSlider(),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .028),
        Text(
          'home.welcome'.tr(),
          style: TextStyle(
            color: Color.fromARGB(255, 146, 52, 17),
            fontSize: 32,
            fontWeight: FontWeight.w100,
            fontFamily: 'Pacifico',
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .04,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 5),
              child: Text(
                'home.mostVisited'.tr(),
                style: TextStyle(
                  color: Color.fromARGB(255, 146, 52, 17),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .015,
            ),

            //child: modelforplace(placemodell: Actions[NavigationDestination],),
            feturedcustemlist(),
          ],
        )
      ]),
    ));
  }
}
