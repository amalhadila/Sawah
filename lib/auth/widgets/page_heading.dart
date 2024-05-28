import 'package:flutter/material.dart';

class PageHeading extends StatelessWidget {
  final String title;
  const PageHeading({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 25),
      child: Text(
        textAlign: TextAlign.center,
        title,
        style: const TextStyle(
            color: Colors.orange,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'NotoSerif'),
      ),
    );
  }
}
