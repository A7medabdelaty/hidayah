import 'package:flutter/material.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_time_row.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PrayerTimesList extends StatelessWidget {
  final PrayerTimesModel prayerTimesModel;

  const PrayerTimesList({super.key, required this.prayerTimesModel});

  @override
  Widget build(BuildContext context) {
    final prayers = [
      (LucideIcons.sunrise, 'Fajr', prayerTimesModel.data.timings.fajr),
      (LucideIcons.sun, 'Sunrise', prayerTimesModel.data.timings.sunrise),
      (LucideIcons.sunMedium, 'Dhuhr', prayerTimesModel.data.timings.dhuhr),
      (LucideIcons.sunset, 'Asr', prayerTimesModel.data.timings.asr),
      (LucideIcons.moonStar, 'Maghrib', prayerTimesModel.data.timings.maghrib),
      (LucideIcons.moon, 'Isha', prayerTimesModel.data.timings.isha),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: prayers.length,
      itemBuilder: (context, index) => PrayerTimeRow(
        icon: prayers[index].$1,
        label: prayers[index].$2,
        time: prayers[index].$3,
        isNext: index == 0,
        index: index,
      ),
    );
  }
}
