import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_bloc.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';

class PrayerLocationHeader extends StatelessWidget {
  const PrayerLocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesBloc, PrayerTimesStates>(
      builder: (context, state) {
        if (state is PrayerTimesLoading) {
          return const Row(
            children: [
              Icon(Icons.location_on, color: Colors.white),
              SizedBox(width: 6),
              Text(
                "Getting location...",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        }
        return Row(
          children: [
            const Icon(Icons.location_on, color: Colors.white),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                state is PrayerTimesSuccess
                    ? state.locationAddress
                    : "Getting location...",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
