import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hidayah/features/prayer_time/presentation/view/prayer_times_view.dart';

class HomeView extends StatelessWidget {
  static const String routeName = '/homeView';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("appName".tr(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none))
          ],
        ),
        body: const PrayerTimesView());
  }
}
