import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hidayah/core/constants/app_colors.dart';
import 'package:hidayah/core/services/locale_service.dart';
import 'package:hidayah/core/utils/prayer_time_calculator.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';

class NextPrayerIndicator extends StatefulWidget {
  final PrayerTimesModel prayerTimesModel;

  const NextPrayerIndicator({super.key, required this.prayerTimesModel});

  @override
  State<NextPrayerIndicator> createState() => _NextPrayerIndicatorState();
}

class _NextPrayerIndicatorState extends State<NextPrayerIndicator> {
  Timer? _timer;
  bool _disposed = false; // Add flag to track disposal
  late var nextPrayer = PrayerTimeCalculator.getNextPrayer(
    widget.prayerTimesModel.data.timings.toJson(),
    locale: LocaleService().getCurrentLocale().languageCode,
  );

  @override
  void initState() {
    super.initState();
    _updateNextPrayer();
    _startTimer();
  }

  @override
  void didUpdateWidget(NextPrayerIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.prayerTimesModel != widget.prayerTimesModel) {
      _updateNextPrayer();
    }
  }

  void _startTimer() {
    final now = DateTime.now();
    final secondsUntilNextMinute = 60 - now.second;

    Future.delayed(Duration(seconds: secondsUntilNextMinute), () {
      if (!_disposed) {
        // Check if widget is still mounted
        _updateNextPrayer();
        _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
          if (!_disposed) {
            // Check before updating
            _updateNextPrayer();
          }
        });
      }
    });
  }

  void _updateNextPrayer() {
    if (!mounted) return; // Additional safety check
    setState(() {
      nextPrayer = PrayerTimeCalculator.getNextPrayer(
        widget.prayerTimesModel.data.timings.toJson(),
        locale: LocaleService().getCurrentLocale().languageCode,
      );
    });
  }

  @override
  void dispose() {
    _disposed = true; // Set flag before canceling timer
    _timer?.cancel();
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
                  '${"nextPrayer".tr()} ${nextPrayer.$1}',
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
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            )
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          height: 4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            widthFactor: 1.0 - nextPrayer.$4, // Reverse the progress value
            alignment: AlignmentDirectional.centerStart,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
