import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sawah/constants.dart';
import 'package:sawah/features/create_tour.dart/presentation/views/createtourview.dart';
import 'package:sawah/features/landmarks/presentation/manger/categories_cubit/categories_cubit_cubit.dart';
import 'package:sawah/features/search/data/repos/search_repo_imp.dart';
import 'package:sawah/features/search/presentation/manager/searh_cubit.dart';
import 'package:sawah/features/store/presentation/views/store_view.dart';
import '../../auth/cach/cach_helper.dart';
import '../../auth/core_login/api/end_point.dart';
import '../../auth/cubit/user_cubit.dart';
import '../../auth/cach/cach_helper.dart';
import '../../auth/core_login/api/end_point.dart';
import '../../auth/cubit/user_cubit.dart';
import '../../core/widgets/appbar.dart';
import '../guide/presentation/views/guide_view.dart';
import '../guide/presentation/views/widgets/toursdetails.dart';
import '../guide/presentation/views/guide_view.dart';
import '../guide/presentation/views/widgets/toursdetails.dart';
import '../image_upload/presentation/pages/image_upload_page.dart';
import '../landmarks/presentation/views/categories_view.dart';
import '../home/pres/views/homeview.dart';
import '../../core/utils/custom_drawer.dart';
import 'package:dio/dio.dart';
import 'package:sawah/core/utils/api_service.dart';
import 'package:sawah/features/landmarks/data/repos/categoriesrepo_impl.dart';
import 'package:sawah/features/home/pres/manager/cubit/most_visited_cubit.dart';

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
    Createtourview(),
    StoreView(),
    CacheHelper().getData(key: apikey.role) == 'user'
        ? ImagesUploadPage()
        : GuideView(),
  ];

  void _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  void initState() {
    super.initState();
    BlocProvider.of<UserCubit>(context).getUserProfile();
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
        appBar:
            (_selectedTab == 2 || _selectedTab == 3) ? null : CustomAppBar(),
        drawer: CustomDrawer(),
        body: _pages[_selectedTab],
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(right: 20, left: 20, bottom: 15, top: 5),
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
            itemCount: 5, // Changed to 3 to match the number of pages
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
                      color: accentColor1,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  Icon(
                    listOfIcons[index],
                    size: size.width * .076,
                    color:
                        index == _selectedTab ? ksecondcolor : Colors.black38,
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
    Icons.landscape,
    Icons.home_rounded,
    FontAwesomeIcons.solidSquarePlus,
    Icons.shopping_bag,
    Icons.camera_alt,
  ];
}
