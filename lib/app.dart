import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidayah/core/services/navigation_service.dart';
import 'package:hidayah/core/services/theme_service.dart';

import 'core/constants/app_constants.dart';
import 'core/cubit/theme/theme_cubit.dart';
import 'core/routing/app_router.dart';

class HidayahApp extends StatelessWidget {
  final AppRouter appRouter;
  const HidayahApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) => MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          debugShowCheckedModeBanner: false,
          title: AppConstants.appName,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          onGenerateRoute: appRouter.generateRoute,
          initialRoute: '/splashScreen',
        ),
      ),
    );
  }
}
