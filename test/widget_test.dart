import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hidayah/app.dart';
import 'package:hidayah/core/routing/app_router.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/lang',
        fallbackLocale: const Locale('en'),
        child: HidayahApp(
          appRouter: AppRouter(),
        ),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
