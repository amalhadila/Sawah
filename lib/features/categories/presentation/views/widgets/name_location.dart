import 'package:flutter/material.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/style.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({
    Key? key,
    required this.name,
    required this.location,
  }) : super(key: key);

  final String name;
  final String location;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TabBar(
        controller: _tabController,
        indicatorWeight: 1,
        dividerColor: kbackgroundcolor,
        //  labelPadding: const EdgeInsets.only(bottom: 12, right: 25),
        indicatorColor: kmaincolor,
        isScrollable: true,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        tabs: const [
          Tab(text: 'Information'),
          Tab(text: 'Reviews'),
        ],
      ),
      Container(
        height: 40,
        child: TabBarView(
          controller: _tabController,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 47),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.name,
                            style: Textstyle.textStyle16,
                            softWrap: true,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: klocicon,
                              size: 14,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              widget.location,
                              style: Textstyle.textStyle16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Text('Reviews will be here'),
            ),
          ],
        ),
      ),
    ]);
  }
}
