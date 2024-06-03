// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:graduation/auth/cubit/user_cubit.dart';
// import 'package:graduation/auth/screens/sign_in_screen.dart';

// void main() {
//   runApp(
//     EasyLocalization(
//       supportedLocales: const [Locale('en'), Locale('ar')],
//       saveLocale: true,
//       startLocale: const Locale('en'),
//       path: 'assets/lang',
//       fallbackLocale: const Locale('en'),
//       child:   BlocProvider(
//       create: (context) => UserCubit(),
//       child: const Sawah(),
//     ),
//     ),

//   );
// }

// class Sawah extends StatelessWidget {
//   const Sawah({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignInScreen(),
//     // .router(
//     //   localizationsDelegates: context.localizationDelegates,
//     //   supportedLocales: context.supportedLocales,
//     //   locale: context.locale,
//     //   routerConfig: AppRouter.router,
//     //   debugShowCheckedModeBanner: false,
//     //   theme: ThemeData.light().copyWith(
//     //       scaffoldBackgroundColor: kbackgroundcolor,
//     //       textTheme: GoogleFonts.interTextTheme()),
//     );
//   }
// }
// // import 'package:dio/dio.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:happy_tech_mastering_api_with_flutter/cache/cache_helper.dart';
// // import 'package:happy_tech_mastering_api_with_flutter/core/api/dio_consumer.dart';
// // import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
// // import 'package:happy_tech_mastering_api_with_flutter/repositories/user_repository.dart';
// // import 'package:happy_tech_mastering_api_with_flutter/screens/sign_in_screen.dart';

// // void main() {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   CacheHelper().init();
// //   runApp(
// //     BlocProvider(
// //       create: (context) =>
// //           UserCubit(UserRepository(api: DioConsumer(dio: Dio()))),
// //       child: const MyApp(),
// //     ),
// //   );
// // }

// // class MyApp extends StatelessWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return const MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       home: SignInScreen(),
// //     );
// //   }
// // }
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/core/utils/app_router.dart';
import 'package:graduation/features/search/data/repos/search_repo_imp.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit.dart';
import 'package:graduation/features/store/data/repo/procat_repo_imple.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/deleteitem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/getcartitems_cubit.dart';
import 'package:graduation/firebase_options.dart';

void main() async{
     WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      saveLocale: true,
      startLocale: const Locale('en'),
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: Sawah()));
}

class Sawah extends StatelessWidget {
  Sawah({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
      create: (context) => DeleteitemCubit(ProcatRepoImple(ApiService(Dio())))),
          BlocProvider(
            create: (context) =>
                AdditemCubit(ProcatRepoImple(ApiService(Dio()))),
          ),
          BlocProvider(
            create: (context) => SearchCubit(SearchRepoImp(ApiService(Dio()))),
          ),
          BlocProvider(
              create: (context) =>
                  GetcartitemsCubit(ProcatRepoImple(ApiService(Dio())))
                    ..fetchcartitems()),
        ],
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: kbackgroundcolor,
              textTheme: GoogleFonts.interTextTheme()),
        ));
  }
}