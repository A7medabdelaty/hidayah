import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
      Position position;
      String locationAddress;

      if (latitude != null && longitude != null) {
        position = locationService.createPosition(latitude, longitude);
        locationAddress = address ??
            await LocationService.getFormattedAddress(
              LatLng(latitude, longitude),
            );
      } else {
        position = await locationService.getCurrentPosition();
        locationAddress = await LocationService.getFormattedAddress(
          LatLng(position.latitude, position.longitude),
        );
      }

      final result = await prayerTimesRepo.fetchPrayerTimes(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      result.fold(
        (failure) => emit(PrayerTimesError(failure.errMessage)),
        (prayerTimes) => emit(PrayerTimesSuccess(prayerTimes, locationAddress)),
      );
    } catch (e) {
      emit(PrayerTimesError(e.toString()));
    }
  }
}
