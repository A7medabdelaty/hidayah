import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hidayah/app.dart';
import 'package:hidayah/core/constants/app_constants.dart';
import 'package:hidayah/core/cubit/locale/locale_cubit.dart';
import 'package:hidayah/core/cubit/theme/theme_cubit.dart';
import 'package:hidayah/core/routing/app_router.dart';
import 'package:hidayah/core/services/service_locator.dart';

void main() {
  setUp(() {
    setupServiceLocator();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: AppConstants.supportedLocales,
        path: 'assets/lang',
        fallbackLocale: const Locale('en'),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => LocaleCubit()),
            BlocProvider(create: (_) => ThemeCubit()),
          ],
          child: HidayahApp(
            appRouter: AppRouter(),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
