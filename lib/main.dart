import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/core/utils/app_router.dart';

void main() {
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      saveLocale: true,
      startLocale: const Locale('en'),
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      child: const Sawah()));
}

class Sawah extends StatelessWidget {
  const Sawah({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: kbackgroundcolor,
          textTheme: GoogleFonts.interTextTheme()),
    );
  }
}
