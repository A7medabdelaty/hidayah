import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hidayah/core/constants/image_manager.dart';

import '../../../../core/extensions/navigation_extensions.dart';
import '../../../../core/routing/routes.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1200), () {
      context.pushNamed(Routes.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(ImageManager.appLogo)),
    );
  }
}
