import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/categories/presentation/manger/categories_cubit/categories_cubit_cubit.dart';
import 'package:graduation/features/search/data/repos/search_repo.dart';
import 'package:graduation/features/search/data/repos/search_repo_imp.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit.dart';
import '../../core/utils/assets.dart';
import '../../core/widgets/appbar.dart';
import '../image_upload/presentation/pages/image_upload_page.dart';
import '../../constants.dart';
import '../categories/presentation/views/categories_view.dart';
import '../home/pres/views/homeview.dart';
import '../../core/utils/custom_drawer.dart';
import 'package:dio/dio.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/categories/data/repos/categoriesrepo_impl.dart';
import 'package:graduation/features/home/pres/manager/cubit/most_visited_cubit.dart';

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
    return MultiBlocProvider(
      providers: [
         BlocProvider(
      create: (context) =>
          MostVisitedCubit(CategoriesRepoImpl(ApiService(Dio())))
            ..fetchmostvisited()),
            BlocProvider(
        create: (context) =>
            CategoriesCubitCubit(CategoriesRepoImpl(ApiService(Dio())))
              ..fetchCategories(),
      ),
         BlocProvider(
        create: (context) =>
            SearchCubit(SearchRepoImp( ApiService(Dio())))
            
      ),
      
      ],
      child: Scaffold(
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
      ),
    );
  }
}