import 'package:flutter/material.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/core/utils/style.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);

  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 47),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  name,
                  style: Textstyle.textStyle16.copyWith(color: neutralColor3),
                  softWrap: true,
                ),
              ),
              SizedBox(width: 60,),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: accentColor1,
                    size: 19,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    location,
                    style: Textstyle.textStyle16.copyWith(color: neutralColor3),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
