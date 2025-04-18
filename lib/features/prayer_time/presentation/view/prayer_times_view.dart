import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/core/services/service_loctor.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_times_card.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_times_header.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_bloc.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';

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
            return const Center(child: CircularProgressIndicator());
          } else if (state is PrayerTimesSuccess) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const PrayerTimesHeader(),
                    Expanded(
                      child: PrayerTimesCard(
                        prayerTimesModel: state.prayerTimesModel,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is PrayerTimesError) {
            return Center(child: Text(state.errMessage));
          }
          return const Center(child: Text('Something Went Wrong!!!'));
        },
      ),
    );
  }
}
