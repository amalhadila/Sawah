import 'package:flutter/material.dart';
import 'package:graduation/core/widgets/appbar.dart';

class NotfoundPageBody extends StatelessWidget {
  const NotfoundPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: Colors.white,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/No data.gif'),
            ),
            Text(
              'UPs! .... No Results found',
              style: TextStyle(
                color: Color(0xffDB7100),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Please try another search',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
