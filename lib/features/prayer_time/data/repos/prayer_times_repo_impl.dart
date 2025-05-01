import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hidayah/core/constants/endpoint_constants.dart';
import 'package:hidayah/core/errors/api_failures.dart';
import 'package:hidayah/core/errors/failures.dart';
import 'package:hidayah/core/network/api_consumer.dart';
import 'package:hidayah/core/utils/app_shared_preferences.dart';
import 'package:hidayah/features/prayer_time/data/models/cached_prayer_data.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:intl/intl.dart';

class PrayerTimesRepoImpl implements PrayerTimesRepo {
  static const String _cacheKey = 'cached_prayer_data';
  final ApiConsumer apiConsumer;
  final AppPreferences _prefs;
  final String defaultMethod;
  final String defaultTune;

  PrayerTimesRepoImpl({
    required this.apiConsumer,
    required AppPreferences prefs,
    this.defaultMethod = '5',
    this.defaultTune = '0,0,0,0,0,0,0,0,0',
  }) : _prefs = prefs;

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<void> _cachePrayerData(CachedPrayerData data) async {
    await _prefs.saveModel(_cacheKey, data, (model) => model.toJson());
  }

  @override
  Future<Either<Failure, CachedPrayerData>> getCachedPrayerTimes() async {
    final cachedData = _prefs.getModel(_cacheKey, CachedPrayerData.fromJson);
    if (cachedData != null) {
      return Right(cachedData);
    }
    return Left(ApiFailure('No cached data available'));
  }

  Future<Either<Failure, LatLng>> _getLocation(
      {double? latitude, double? longitude}) async {
    if (latitude != null && longitude != null) {
      return Right(LatLng(latitude, longitude));
    }

    try {
      final position = await Geolocator.getCurrentPosition();
      return Right(LatLng(position.latitude, position.longitude));
    } catch (e) {
      final cachedResult = await getCachedPrayerTimes();
      return cachedResult.fold(
        (failure) => Left(ApiFailure(
            'Location services disabled and no cached location available')),
        (cachedData) => Right(cachedData.location),
      );
    }
  }

  @override
  Future<Either<Failure, PrayerTimesModel>> fetchPrayerTimes({
    double? latitude,
    double? longitude,
    DateTime? date,
  }) async {
    try {
      final hasInternet = await _checkInternet();
      if (!hasInternet) {
        return getCachedPrayerTimes().then(
          (result) => result.fold(
            (failure) => Left(failure),
            (cachedData) => Right(cachedData.prayerTimes),
          ),
        );
      }

      final locationResult =
          await _getLocation(latitude: latitude, longitude: longitude);
      return await locationResult.fold(
        (failure) => Left(failure),
        (location) async {
          final targetDate = date ?? DateTime.now();
          final formattedDate = DateFormat('dd-MM-yyyy').format(targetDate);

          final response = await apiConsumer.get(
            '${EndpointConstants.prayerTimesEndpoint}/$formattedDate',
            queryParameters: {
              'latitude': location.latitude.toString(),
              'longitude': location.longitude.toString(),
              'tune': defaultTune,
              'method': defaultMethod,
            },
          );

          if (response == null) {
            return Left(ApiFailure('No data received from the server'));
          }

          final prayerTimes = PrayerTimesModel.fromJson(response);
          await _cachePrayerData(CachedPrayerData(
            prayerTimes: prayerTimes,
            location: location,
            address: '', // Address will be set by the LocationService
            timestamp: DateTime.now(),
          ));

          return Right(prayerTimes);
        },
      );
    } catch (e) {
      return Left(ApiFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
