import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/core/services/service_loctor.dart';
import 'package:hidayah/core/utils/location_helper.dart';
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
      create: (context) {
        final bloc = PrayerTimesBloc(getIt.get<PrayerTimesRepo>());
        _initializeLocation(context, bloc);
        return bloc;
      },
      child: BlocBuilder<PrayerTimesBloc, PrayerTimesStates>(
        builder: (context, state) {
          if (state is PrayerTimesLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is PrayerTimesSuccess) {
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const PrayerTimesHeader(),
                        // Remove the location button from here
                      ],
                    ),
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

  Future<void> _initializeLocation(
      BuildContext context, PrayerTimesBloc bloc) async {
    final hasPermission =
        await LocationHelper.handleLocationPermission(context);
    if (hasPermission) {
      bloc.fetchPrayerTimes();
    }
  }
}
