import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrayerTimesHeader extends StatelessWidget {
  const PrayerTimesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'prayerTimes'.tr(),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          'prayerTimesDesc'.tr(),
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
