import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/core/errors/api_failures.dart';
import 'package:hidayah/core/services/location_service.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';

class PrayerTimesBloc extends Cubit<PrayerTimesStates> {
  final PrayerTimesRepo prayerTimesRepo;
  final LocationService locationService;

  PrayerTimesBloc({
    required this.prayerTimesRepo,
    required this.locationService,
  }) : super(PrayerTimesInitial()) {
    _loadCachedData();
  }

  Future<void> _loadCachedData() async {
    final result = await prayerTimesRepo.getCachedPrayerTimes();
    result.fold(
      (failure) => fetchPrayerTimes(),
      (cachedData) {
        emit(PrayerTimesSuccess(
          cachedData.prayerTimes,
          cachedData.address,
          isFromCache: true,
        ));
        // Try to fetch fresh data if possible
        _hasInternetConnection().then((hasInternet) {
          if (hasInternet) fetchPrayerTimes();
        });
      },
    );
  }

  Future<bool> _hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  Future<void> fetchPrayerTimes({double? latitude, double? longitude}) async {
    if (state is! PrayerTimesSuccess) {
      emit(PrayerTimesLoading());
    }

    final result = await prayerTimesRepo.fetchPrayerTimes(
      latitude: latitude,
      longitude: longitude,
    );

    result.fold(
      (failure) {
        if (failure is ApiFailure &&
            failure.errMessage.contains('No internet')) {
          if (state is! PrayerTimesSuccess) {
            emit(PrayerTimesOffline());
          }
        } else {
          if (state is! PrayerTimesSuccess) {
            emit(PrayerTimesError(failure.errMessage));
          }
        }
      },
      (prayerTimes) async {
        final cachedData = await prayerTimesRepo.getCachedPrayerTimes();
        final address = cachedData.fold(
          (failure) => 'Unknown location',
          (data) => data.address,
        );

        emit(PrayerTimesSuccess(
          prayerTimes,
          address,
          isFromCache: false,
        ));
      },
    );
  }
}
