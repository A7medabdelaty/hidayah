import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hidayah/core/constants/endpoint_constants.dart';
import 'package:hidayah/core/errors/api_failures.dart';
import 'package:hidayah/core/errors/failures.dart';
import 'package:hidayah/core/network/api_consumer.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:intl/intl.dart';

class PrayerTimesRepoImpl implements PrayerTimesRepo {
  final ApiConsumer apiConsumer;
  final String defaultMethod;
  final String defaultTune;

  PrayerTimesRepoImpl({
    required this.apiConsumer,
    this.defaultMethod = '5',
    this.defaultTune = '0,0,0,0,0,0,0,0,0',
  });

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permission denied';
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<Either<Failure, PrayerTimesModel>> fetchPrayerTimes({
    double? latitude,
    double? longitude,
    DateTime? date,
  }) async {
    try {
      final position = latitude == null || longitude == null
          ? await _getCurrentLocation()
          : null;

      final targetDate = date ?? DateTime.now();
      final formattedDate = DateFormat('dd-MM-yyyy').format(targetDate);

      final response = await apiConsumer.get(
        '${EndpointConstants.prayerTimesEndpoint}/$formattedDate',
        queryParameters: {
          'latitude': (latitude ?? position?.latitude).toString(),
          'longitude': (longitude ?? position?.longitude).toString(),
          'tune': defaultTune,
          'method': defaultMethod,
        },
      );

      if (response == null) {
        return Left(ApiFailure('No data received from the server'));
      }

      return Right(PrayerTimesModel.fromJson(response));
    } on LocationServiceDisabledException {
      return Left(ApiFailure('Location services are disabled'));
    } on DioException catch (dioException) {
      return Left(ApiFailure.fromDioException(dioException));
    } catch (e) {
      return Left(ApiFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
