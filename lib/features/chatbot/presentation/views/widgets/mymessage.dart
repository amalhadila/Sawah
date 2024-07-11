import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';

class MyMessage extends StatelessWidget {
  final String message;

  MyMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text("Me",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700)),
                Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(78, 133, 205, 201),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(message,
                      style: Textstyle.textStyle14.copyWith(
                          color: neutralColor3, fontWeight: FontWeight.w400)),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16.0),
            child: CircleAvatar(
              child: Text("M", style: TextStyle(fontWeight: FontWeight.bold)),
              backgroundColor: accentColor3,
            ),
          ),
        ],
      ),
    );
  }
}
