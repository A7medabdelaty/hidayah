import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/core/constants/app_colors.dart';
import 'package:hidayah/core/services/service_loctor.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_time_row.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_bloc.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PrayerTimesBloc(getIt.get<PrayerTimesRepo>())
        ..fetchPrayerTimes(city: "cairo", country: 'eg'),
      child: BlocBuilder<PrayerTimesBloc, PrayerTimesStates>(
          builder: (context, state) {
        if (state is PrayerTimesLoading) {
          return CircularProgressIndicator();
        } else if (state is PrayerTimesSuccess) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('prayerTimes'.tr(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('prayerTimesDesc'.tr(),
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade700,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.location_on,
                                            color: Colors.white),
                                        SizedBox(width: 6),
                                        Text("Cairo, Egypt",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        Spacer(),
                                        Icon(Icons.settings,
                                            color: Colors.white)
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                        "17 Ramadan 1445 | Thursday, 17 April 2025",
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12)),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(Icons.access_time,
                                                color: Colors.white),
                                            SizedBox(width: 8),
                                            Text("Next Prayer: Fajr",
                                                style: TextStyle(
                                                    color: Colors.white))
                                          ],
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: const Text("00:42",
                                              style: TextStyle(
                                                  color: Colors.green)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Container(
                                      height: 4,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: FractionallySizedBox(
                                        widthFactor: 0.6,
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              ListView.builder(
                                padding: const EdgeInsets.all(0),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  final prayers = [
                                    (
                                      LucideIcons.sunrise,
                                      'Fajr',
                                      state.prayerTimesModel.data.timings.fajr
                                    ),
                                    (
                                      LucideIcons.sun,
                                      'Sunrise',
                                      state
                                          .prayerTimesModel.data.timings.sunrise
                                    ),
                                    (
                                      LucideIcons.sunMedium,
                                      'Dhuhr',
                                      state.prayerTimesModel.data.timings.dhuhr
                                    ),
                                    (
                                      LucideIcons.sunset,
                                      'Asr',
                                      state.prayerTimesModel.data.timings.asr
                                    ),
                                    (
                                      LucideIcons.moonStar,
                                      'Maghrib',
                                      state
                                          .prayerTimesModel.data.timings.maghrib
                                    ),
                                    (
                                      LucideIcons.moon,
                                      'Isha',
                                      state.prayerTimesModel.data.timings.isha
                                    ),
                                  ];
                                  return PrayerTimeRow(
                                    icon: prayers[index].$1,
                                    label: prayers[index].$2,
                                    time: prayers[index].$3,
                                    isNext: index == 0,
                                    index: index,
                                  );
                                },
                              ),
                              Container(
                                color: AppColors.lightGreenColor,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "viewQiblaDirection".tr(),
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.location_on_outlined,
                                    color: Colors.green),
                                label: const Text("Change Location",
                                    style: TextStyle(color: Colors.green)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        } else if (state is PrayerTimesError) {
          return Center(
            child: Text(state.errMessage),
          );
        }
        return Center(
          child: Text('Something Went Wrong!!!'),
        );
      }),
    );
  }
}
