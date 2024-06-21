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
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:happy_tech_mastering_api_with_flutter/cache/cache_helper.dart';
// import 'package:happy_tech_mastering_api_with_flutter/core/api/dio_consumer.dart';
// import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
// import 'package:happy_tech_mastering_api_with_flutter/repositories/user_repository.dart';
// import 'package:happy_tech_mastering_api_with_flutter/screens/sign_in_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   CacheHelper().init();
//   runApp(
//     BlocProvider(
//       create: (context) =>
//           UserCubit(UserRepository(api: DioConsumer(dio: Dio()))),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignInScreen(),
//     );
//   }
// }
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/api_service.dart';
import 'package:graduation/core/utils/app_router.dart';
import 'package:graduation/features/review_onlandmark/data/repo/revwrepoimp.dart';
import 'package:graduation/features/review_onlandmark/pres/cubit/reviewcubit.dart';
import 'package:graduation/features/search/data/repos/search_repo_imp.dart';
import 'package:graduation/features/search/presentation/manager/searh_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/addtowishlist_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/checkavailability_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/deletewishlistitem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/fetchwishlist_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/productbyid_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/searchproduct_cubit.dart';
import 'package:graduation/firebase/firedatabase.dart';
import 'package:graduation/firebase_options.dart';
import 'package:graduation/auth/cach/cach_helper.dart';
import 'package:graduation/auth/core_login/api/dio_consumer.dart';
import 'package:graduation/auth/cubit/user_cubit.dart';
import 'package:graduation/auth/repos/user_repo.dart';
import 'package:graduation/auth/screens/sign_in_screen.dart';

import 'package:graduation/features/store/data/repo/procat_repo_imple.dart';
import 'package:graduation/features/store/presentation/manager/cubit/additem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/deleteitem_cubit.dart';
import 'package:graduation/features/store/presentation/manager/cubit/cubit/getcartitems_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async { 
  print("Handling a background message: ${message.notification!.body}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
   requestNotificationPermission();
  
  FirebaseMessaging.instance.requestPermission();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.notification?.title}');
    
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  
  //final fcmToken = await FirebaseMessaging.instance.getToken();
  //print('Message data: $fcmToken');
  FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.subscribeToTopic("news");
  await CacheHelper().init();
  final Dio dio = Dio();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      saveLocale: true,
      startLocale: const Locale('en'),
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: Sawah(dio: dio),
    ),
  );
}

Future<void> requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('Notification permission granted: ${settings.authorizationStatus}');
}

class Sawah extends StatelessWidget {
  final Dio dio;

  Sawah({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CheckavailabilityCubit(ProcatRepoImple(ApiService(dio)))),
        BlocProvider(
          create: (context) =>
              DeletewishlistitemCubit(ProcatRepoImple(ApiService(dio))),
        ),
        BlocProvider(
          create: (context) =>
              DeleteitemCubit(ProcatRepoImple(ApiService(dio))),
        ),
        BlocProvider(
          create: (context) =>
              AddtowishlistCubit(ProcatRepoImple(ApiService(dio))),
        ),
        BlocProvider(
          create: (context) =>
              FetchwishlistCubit(ProcatRepoImple(ApiService(dio)))
                ..fetchwishlist(),
        ),
         BlocProvider(
          create: (context) =>
              ProductbyidCubit(ProcatRepoImple(ApiService(dio)))
                
        ),
        BlocProvider(
          create: (context) =>
              ReviewCubit(Revwrepoimp(ApiService(dio))),
        ),
        BlocProvider(
          create: (context) => AdditemCubit(ProcatRepoImple(ApiService(dio))),
        ),
        BlocProvider(
          create: (context) => SearchCubit(SearchRepoImp(ApiService(dio))),
        ),
        BlocProvider(
          create: (context) =>
              GetcartitemsCubit(ProcatRepoImple(ApiService(dio)))
                ..fetchcartitems(),
        ), BlocProvider(
          create: (context) =>
              AddtowishlistCubit(ProcatRepoImple(ApiService(dio))),
        ),
        BlocProvider(
            create: (context) =>
                SearchproductCubit(ProcatRepoImple(ApiService(Dio())))),
        BlocProvider(
            create: (context) =>
                SearchproductCubit(ProcatRepoImple(ApiService(Dio())))),
        BlocProvider(
          create: (context) =>
              UserCubit(UserRepository(diocosumer: Diocosumer(dio: dio))),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: kbackgroundcolor,
          textTheme: GoogleFonts.interTextTheme(),
        ),
      ),
    );
  }
}
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation/auth/cach/cach_helper.dart';
// import 'package:graduation/auth/core_login/api/dio_consumer.dart';
// import 'package:graduation/auth/cubit/user_cubit.dart';
// import 'package:graduation/auth/repos/user_repo.dart';
// import 'package:graduation/auth/screens/sign_in_screen.dart';

// void main() {
//    WidgetsFlutterBinding.ensureInitialized();
//   CacheHelper().init();
//   final Dio dio = Dio(); // Instantiate Dio
//   runApp(
//     BlocProvider(
//       create: (context) => UserCubit(UserRepository(diocosumer: Diocosumer(dio: dio))),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SignInScreen(),
//     );
//   }
// }
