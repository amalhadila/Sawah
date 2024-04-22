import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import '../../core/utils/assets.dart';
import '../../core/widgets/appbar.dart';
import '../image_upload/presentation/pages/image_upload_page.dart';
import '../../constants.dart';
import '../categories/presentation/views/categories_view.dart';
import '../home/pres/views/homeview.dart';
import '../splachview/preslayer/views/widget/custom_drawer.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State {
  int _selectedTab = 1;

  List _pages = [CategoriesView(), Homepage(), ImagesUploadPage()];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: _pages[_selectedTab],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: ksecondcolor,
        style: TabStyle.react,
        items: [
          TabItem(icon: Image.asset(AssetsData.key)),
          TabItem(icon: Image.asset(AssetsData.home)),
          TabItem(icon: Image.asset(AssetsData.camera)),
        ],
        initialActiveIndex: 1,
        onTap: (int index) => _changeTab(index),
      ),
    );
  }
}