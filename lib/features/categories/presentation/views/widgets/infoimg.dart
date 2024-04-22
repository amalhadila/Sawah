import 'package:flutter/material.dart';

class infoimg extends StatelessWidget {
  const infoimg({
    super.key,
    required this.imagelink,
  });

  final String imagelink;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
          height: MediaQuery.of(context).size.height * .31,
          child: Image.asset(
            imagelink,
            fit: BoxFit.fill,
          )),
    );
  }
}
