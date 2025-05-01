import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/core/services/service_locator.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/offline_state.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_times_card.dart';
import 'package:hidayah/features/prayer_time/presentation/view/widgets/prayer_times_header.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_bloc.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';

class PrayerTimesView extends StatelessWidget {
  const PrayerTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PrayerTimesBloc>(),
      child: const _PrayerTimesContent(),
    );
  }
}

class _PrayerTimesContent extends StatefulWidget {
  const _PrayerTimesContent();

  @override
  State<_PrayerTimesContent> createState() => _PrayerTimesContentState();
}

class _PrayerTimesContentState extends State<_PrayerTimesContent> {
  @override
  void initState() {
    super.initState();
    _initializePrayerTimes(context, context.read<PrayerTimesBloc>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesBloc, PrayerTimesStates>(
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
                  if (state.isFromCache)
                    Container(
                      color: Colors.amber.shade100,
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      child: const Text(
                        'Showing last available data',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  Expanded(
                    child: Padding(
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
                  ),
                ],
              ),
            ),
          );
        } else if (state is PrayerTimesOffline) {
          return const Scaffold(
            body: OfflineState(),
          );
        } else if (state is PrayerTimesError) {
          return Center(child: Text(state.errMessage));
        }
        return const Center(child: Text('Something Went Wrong!!!'));
      },
    );
  }
}

Future<void> _initializePrayerTimes(
    BuildContext context, PrayerTimesBloc bloc) async {
  // Just fetch prayer times directly - the repository will handle cached data
  bloc.fetchPrayerTimes();
}
