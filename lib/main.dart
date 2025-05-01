import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/app_bloc_observer.dart';
import 'package:hidayah/core/services/locale_service.dart';
import 'package:hidayah/core/services/service_locator.dart';

import 'app.dart';
import 'core/constants/app_constants.dart';
import 'core/cubit/locale/locale_cubit.dart';
import 'core/cubit/theme/theme_cubit.dart';
import 'core/routing/app_router.dart';
import 'core/utils/app_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await AppPreferences().init();

  // Get the device's language code (e.g. 'en' from 'en_US')
  final String deviceLocale = LocaleService().getCurrentLocale().languageCode;

  // Check if the device language is in our supported locales
  final bool isSupported = AppConstants.supportedLocales
      .map((locale) => locale.languageCode)
      .contains(deviceLocale);

  runApp(EasyLocalization(
    supportedLocales: AppConstants.supportedLocales,
    path: 'assets/lang',
    fallbackLocale: const Locale('en'),
    startLocale: isSupported ? Locale(deviceLocale) : const Locale('en'),
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: HidayahApp(appRouter: AppRouter()),
    ),
  ));
}
