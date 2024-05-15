import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';

class CustomAlertDialog extends StatefulWidget {
  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  List<String> selectedPlaces = [];
  List<String> selectedTypes = [];

  List<String> places = [
    'filter.cairo'.tr(),
    'filter.giza'.tr(),
    'filter.luxor'.tr(),
    'filter.aswan'.tr()
  ];
  List<String> types = [
    'filter.archaeologicalAreas'.tr(),
    'filter.temples'.tr(),
    'filter.mosques'.tr(),
    'Churches',
    'filter.museums'.tr(),
    'filter.touristAttractions'.tr()
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.fromLTRB(5, 15, 5, 30),
      title: Row(
        children: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          SizedBox(width: 10),
          Text('filter.filter'.tr()),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ExpansionTile(
            title: Text(
              'filter.city'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            children: places.map((place) {
              return CheckboxListTile(
                activeColor: kmaincolor,
                checkColor: kmaincolor,
                title: Text(place),
                checkboxShape: CircleBorder(),
                value: selectedPlaces.contains(place),
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      selectedPlaces.add(place);
                    } else {
                      selectedPlaces.remove(place);
                    }
                  });
                },
              );
            }).toList(),
          ),
          ExpansionTile(
            title: Text(
              'filter.sections'.tr(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            children: types.map((type) {
              return CheckboxListTile(
                activeColor: kmaincolor,
                checkColor: kmaincolor,
                checkboxShape: CircleBorder(),
                title: Text(type),
                value: selectedTypes.contains(type),
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      selectedTypes.add(type);
                    } else {
                      selectedTypes.remove(type);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('filter.close'.tr()),
        ),
        TextButton(
          onPressed: () {
            // send the request with the selected filters
            Navigator.of(context).pop();
          },
          child: Text('filter.apply'.tr()),
        )
      ],
    );
  }
}
