import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation/auth/screens/sign_in_screen.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/features/categories/data/model/categories_model.dart';
import 'package:graduation/features/categories/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/categories/presentation/views/Landmarks_view.dart';
import 'package:graduation/features/categories/presentation/views/categories_view.dart';
import 'package:graduation/features/categories/presentation/views/info_view.dart';
import 'package:graduation/features/chat/presentation/views/widgets/chathome_body.dart';
import 'package:graduation/features/contact_us.dart/contact_us_view.dart';
import 'package:graduation/features/home/data/models/most_visited_model/most_visited_model.dart';
import 'package:graduation/features/introduction_screen/presentation/views/introduction_screen_view.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit.dart';
import 'package:graduation/features/search/presentation/views/notfound_page_view.dart';
import 'package:graduation/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:graduation/features/search/splahview.dart';
import 'package:graduation/features/store/data/product/product.dart';
import 'package:graduation/features/store/presentation/views/product_info_view.dart';
import 'package:graduation/features/store/presentation/views/store_view.dart';
import 'package:graduation/features/store/presentation/views/widgets/booking_body.dart';
import 'package:graduation/features/store/presentation/views/widgets/cart_body.dart';
import 'package:graduation/features/store/presentation/views/widgets/gr_id.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/bottom_app_bar/bottom_app_bar.dart';
import '../../features/home/pres/views/homeview.dart';
import '../../features/search/data/repos/search_repo_imp.dart';
import '../widgets/loading_widget.dart';

Future<bool> loadShowOnboarding() async {
  final prefs = await SharedPreferences.getInstance();
  print(prefs.getBool('ON_BOARDING'));
  return prefs.getBool('ON_BOARDING') ?? true;
}

abstract class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/home',
          builder: (context, state) {
            return FutureBuilder<bool>(
              future: loadShowOnboarding(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingWidget();
                } else {
                  bool showOnboarding = snapshot.data ?? true;
                  return showOnboarding
                      ? const IntroductionScreenView()
                      : const BottomNavigation();
                }
              },
            );
          }),
      GoRoute(path: '/', builder: (context, state) => StoreView()),
      GoRoute(path: '/homepage', builder: (context, state) => Homepage()),
      GoRoute(path: '/uu', builder: (context, state) => SplashView()),
      GoRoute(
          path: '/ChatHomeScreen',
          builder: (context, state) => ChatHomeScreen()),
      GoRoute(path: '/sign', builder: (context, state) => SignInScreen()),
      GoRoute(path: '/CartScreen', builder: (context, state) => CartScreen()),
      GoRoute(path: '/BookingPage', builder: (context, state) => BookingPage()),
      GoRoute(
          path: '/productinfo',
          builder: (context, state) => ProductInfoView(
                products: state.extra as Product,
              )),
      GoRoute(
          path: '/contactus',
          builder: (context, state) => const ContactUsView()),
      GoRoute(
          path: '/searchview',
          builder: (context, state) => BlocProvider(
                create: (context) =>
                    SearchCubit(SearchRepoImp(ApiService(Dio()))),
                child: SearchViewBody(
                  name: state.extra as String,
                ),
              )),
      GoRoute(
          path: '/notfound_page_view',
          builder: (context, state) => BlocProvider(
                create: (context) =>
                    SearchCubit(SearchRepoImp(ApiService(Dio()))),
                child: const NotfoundPage(),
              )),
      GoRoute(
          path: '/CategoriesView',
          builder: (context, state) => const CategoriesView()),
      GoRoute(
          path: '/pro',
          builder: (context, state) => GrId(
                categoryId: state.extra as String,
              )),
      GoRoute(
          path: '/LandmarksBody',
          builder: (context, state) => Landmarks_view(
                categorymodel: state.extra as CategoriesModel,
              )),
      GoRoute(
          path: '/Information',
          builder: (context, state) => Infoview(
                landmaroncatkmodel: state.extra as LandmarkOnCatModel,
              )),
      GoRoute(
          path: '/mostvisitedInformation',
          builder: (context, state) => Infoview(
                mostVisitedModel: state.extra as MostVisitedModel,
              )),
    ],
  );
}
