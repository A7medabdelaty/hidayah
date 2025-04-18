import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidayah/core/constants/app_colors.dart';
import 'package:hidayah/core/services/locale_service.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/next_prayer_indicator.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_location_header.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_times_list.dart';

class PrayerTimesCard extends StatelessWidget {
  final PrayerTimesModel prayerTimesModel;

  const PrayerTimesCard({super.key, required this.prayerTimesModel});

  @override
  Widget build(BuildContext context) {
    final Date date = prayerTimesModel.data.date;
    final String appLocale = LocaleService().getCurrentLocale().languageCode;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16.sp),
            decoration: BoxDecoration(
              color: Colors.green.shade700,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrayerLocationHeader(),
                SizedBox(height: 8.sp),
                Text(
                  "${date.hijri.day} ${appLocale == 'ar' ? date.hijri.month.ar : date.hijri.month.en} ${date.hijri.year} | ${appLocale == 'ar' ? date.hijri.weekday.ar : date.gregorian.weekday.en}, ${date.readable}",
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                ),
                SizedBox(height: 14.sp),
                NextPrayerIndicator(prayerTimesModel: prayerTimesModel),
              ],
            ),
          ),
          PrayerTimesList(prayerTimesModel: prayerTimesModel),
          Container(
            color: AppColors.foregroundColor,
            child: TextButton(
              onPressed: () {},
              child: Text(
                "viewQiblaDirection".tr(),
                style: TextStyle(color: AppColors.primaryColor),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on_outlined, color: Colors.green),
            label: const Text(
              "Change Location",
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
