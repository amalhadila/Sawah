import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graduation/main.dart';

void main() {
  // This is necessary for EasyLocalization to work in tests
  TestWidgetsFlutterBinding.ensureInitialized();

  // Create a Dio instance for testing
  final Dio dio = Dio();

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Initialize the localization
    await EasyLocalization.ensureInitialized();

    // Build our app and trigger a frame with localization
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        saveLocale: false,
        path: 'assets/lang',
        fallbackLocale: const Locale('en'),
        child: Sawah(dio: dio),
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
