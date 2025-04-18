import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidayah/core/constants/app_colors.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';
import 'package:hidayah/features/prayer_time/utils/prayer_time_calculator.dart';

class NextPrayerIndicator extends StatefulWidget {
  final PrayerTimesModel prayerTimesModel;

  const NextPrayerIndicator({super.key, required this.prayerTimesModel});

  @override
  State<NextPrayerIndicator> createState() => _NextPrayerIndicatorState();
}

class _NextPrayerIndicatorState extends State<NextPrayerIndicator> {
  late Timer _timer;
  late var nextPrayer = PrayerTimeCalculator.getNextPrayer(
    widget.prayerTimesModel.data.timings.toJson(),
  );

  @override
  void initState() {
    super.initState();
    // Initial update
    _updateNextPrayer();
    // Calculate seconds until next minute
    final now = DateTime.now();
    final secondsUntilNextMinute = 60 - now.second;

    // Initial delay to sync with minute
    Future.delayed(Duration(seconds: secondsUntilNextMinute), () {
      _updateNextPrayer();
      // Then start periodic updates every minute
      _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
        _updateNextPrayer();
      });
    });
  }

  void _updateNextPrayer() {
    setState(() {
      nextPrayer = PrayerTimeCalculator.getNextPrayer(
        widget.prayerTimesModel.data.timings.toJson(),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, color: AppColors.white),
                SizedBox(width: 8.w),
                Text(
                  "Next Prayer: ${nextPrayer.$1}",
                  style: TextStyle(color: AppColors.white),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                nextPrayer.$3,
                style: TextStyle(color: AppColors.primaryColor),
              ),
            )
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          height: 4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            widthFactor: nextPrayer.$4, // Using the progress value
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
