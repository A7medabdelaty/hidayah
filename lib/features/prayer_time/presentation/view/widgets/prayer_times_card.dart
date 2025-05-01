import 'dart:io';

import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidayah/core/constants/app_colors.dart';
import 'package:hidayah/core/services/locale_service.dart';
import 'package:hidayah/core/services/navigation_service.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/next_prayer_indicator.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_location_header.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_times_list.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_bloc.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';

class PrayerTimesCard extends StatelessWidget {
  final PrayerTimesModel prayerTimesModel;

  const PrayerTimesCard({super.key, required this.prayerTimesModel});

  @override
  Widget build(BuildContext context) {
    final Date date = prayerTimesModel.data.date;
    final String appLocale = LocaleService().getCurrentLocale().languageCode;
    return BlocBuilder<PrayerTimesBloc, PrayerTimesStates>(
        builder: (context, state) {
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
                    "${date.hijri.day} ${appLocale == 'ar' ? date.hijri.month.ar : date.hijri.month.en} ${date.hijri.year} | ${appLocale == 'ar' ? date.hijri.weekday.ar : date.gregorian.weekday.en} | \u202A${date.readable}\u202C",
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  ),
                  SizedBox(height: 14.sp),
                  NextPrayerIndicator(prayerTimesModel: prayerTimesModel),
                ],
              ),
            ),
            PrayerTimesList(prayerTimesModel: prayerTimesModel),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16))),
              child: TextButton(
                onPressed: () async {
                  if (!await _checkInternetConnection(context)) return;
                  await NavigationService.pushQiblaView();
                },
                child: Text(
                  "viewQiblaDirection".tr(),
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () async {
                if (!await _checkInternetConnection(context)) return;
                if (!await _checkLocationPermissions(context)) return;

                final bloc = context.read<PrayerTimesBloc>();
                await NavigationService.pushLocationPicker(
                  bloc,
                  (locationData) {
                    bloc.fetchPrayerTimes(
                      latitude: locationData.latLng.latitude,
                      longitude: locationData.latLng.longitude,
                    );
                  },
                );
              },
              icon: const Icon(Icons.location_on_outlined, color: Colors.green),
              label: Text(
                "changeLocation".tr(),
                style: const TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      );
    });
  }
}

Future<bool> _checkInternetConnection(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isEmpty || result[0].rawAddress.isEmpty) {
      if (!context.mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please check your internet connection'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  } catch (e) {
    if (!context.mounted) return false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please check your internet connection'),
        backgroundColor: Colors.red,
      ),
    );
    return false;
  }
}

Future<bool> _checkLocationPermissions(BuildContext context) async {
  final locationEnabled = await Geolocator.isLocationServiceEnabled();
  if (!locationEnabled) {
    if (!context.mounted) return false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enable location services'),
        backgroundColor: Colors.red,
      ),
    );
    return false;
  }

  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    final permissionResult = await Geolocator.requestPermission();
    if (permissionResult == LocationPermission.denied) {
      if (!context.mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission is required'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    if (!context.mounted) return false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please enable location permission from settings'),
        backgroundColor: Colors.red,
      ),
    );
    return false;
  }

  return true;
}
