import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hidayah/core/models/location_data.dart';
import 'package:hidayah/core/services/location_service.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:hidayah/features/prayer_time/presentation/view_model/prayer_times_states.dart';

class PrayerTimesBloc extends Cubit<PrayerTimesStates> {
  final PrayerTimesRepo prayerTimesRepo;
  final LocationService locationService;

  PrayerTimesBloc({
    required this.prayerTimesRepo,
    required this.locationService,
  }) : super(PrayerTimesInitial());

  Future<void> fetchPrayerTimes({
    double? latitude,
    double? longitude,
    String? address,
  }) async {
    emit(PrayerTimesLoading());
    try {
      final LocationData location;
      if (latitude != null && longitude != null) {
        final position = locationService.createPosition(latitude, longitude);
        location = await locationService.getLocationData(
          LatLng(position.latitude, position.longitude),
        );
      } else {
        location = await locationService.getCurrentLocation();
      }

      final result = await prayerTimesRepo.fetchPrayerTimes(
        latitude: location.latLng.latitude,
        longitude: location.latLng.longitude,
      );

      result.fold(
        (failure) => emit(PrayerTimesError(failure.errMessage)),
        (prayerTimes) =>
            emit(PrayerTimesSuccess(prayerTimes, location.address)),
      );
    } catch (e) {
      emit(PrayerTimesError(e.toString()));
    }
  }
}
