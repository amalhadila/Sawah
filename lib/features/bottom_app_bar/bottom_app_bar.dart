import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/landmarks/presentation/manger/categories_cubit/categories_cubit_cubit.dart';
import 'package:graduation/features/search/data/repos/search_repo_imp.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit.dart';
import 'package:graduation/features/store/presentation/views/store_view.dart';
import '../../core/widgets/appbar.dart';
import '../image_upload/presentation/pages/image_upload_page.dart';
import '../landmarks/presentation/views/categories_view.dart';
import '../home/pres/views/homeview.dart';
import '../../core/utils/custom_drawer.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/landmarks/data/repos/categoriesrepo_impl.dart';
import 'package:graduation/features/home/pres/manager/cubit/most_visited_cubit.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationExampleState createState() =>
      _BottomNavigationExampleState();
}

class _BottomNavigationExampleState extends State<BottomNavigation> {
  int _selectedTab = 1;

  final List<Widget> _pages = [
    CategoriesView(),
    Homepage(),
    StoreView(),
    ImagesUploadPage(),
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              MostVisitedCubit(CategoriesRepoImpl(ApiService(Dio())))
                ..fetchmostvisited(),
        ),
        BlocProvider(
          create: (context) =>
              CategoriesCubitCubit(CategoriesRepoImpl(ApiService(Dio())))
                ..fetchCategories(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(SearchRepoImp(ApiService(Dio()))),
        ),
      ],
      child: Scaffold(
        appBar: _selectedTab == 2
            ? null
            : CustomAppBar(), // إزالة الـ AppBar إذا كانت التالت صفحة محددة
        drawer: CustomDrawer(),
        body:
            _pages[_selectedTab], // عرض الصفحة المحددة إذا كانت غير التالت صفحة
        bottomNavigationBar: Container(
          margin: EdgeInsets.all(20),
          height: size.width * .155,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.15),
                blurRadius: 30,
                offset: Offset(0, 10),
              ),
            ],
            borderRadius: BorderRadius.circular(50),
          ),
          child: ListView.builder(
            itemCount: 3, // Changed to 3 to match the number of pages
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: size.width * .024),
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                _changeTab(index);
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: EdgeInsets.only(
                      bottom: index == _selectedTab ? 0 : size.width * .029,
                      right: size.width * .0422,
                      left: size.width * .0422,
                    ),
                    width: size.width * .128,
                    height: index == _selectedTab ? size.width * .014 : 0,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  Icon(
                    listOfIcons[index],
                    size: size.width * .076,
                    color: index == _selectedTab
                        ? Colors.blueAccent
                        : Colors.black38,
                  ),
                  SizedBox(height: size.width * .03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.shopping_bag_outlined,
    Icons.settings_rounded,
    // Adjust your icons based on the number of pages and the items in your bottom navigation bar
  ];
}
