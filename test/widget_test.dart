import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sawah/main.dart';
import 'package:sawah/auth/cach/cach_helper.dart';
import 'package:mockito/mockito.dart';

class MockCacheHelper extends Mock implements CacheHelper {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Dio dio = Dio();
  final mockCacheHelper = MockCacheHelper();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await EasyLocalization.ensureInitialized();

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        saveLocale: false,
        path: 'assets/lang',
        fallbackLocale: const Locale('en'),
        child: Sawah(dio: dio, cacheHelper: mockCacheHelper),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
