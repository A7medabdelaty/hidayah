import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hidayah/core/constants/endpoint_constants.dart';
import 'package:hidayah/core/errors/api_failures.dart';
import 'package:hidayah/core/errors/failures.dart';
import 'package:hidayah/core/network/api_consumer.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';
import 'package:hidayah/features/prayer_time/data/repos/preayer_times_repo.dart';
import 'package:intl/intl.dart';

class PrayerTimesRepoImpl implements PrayerTimesRepo {
  final ApiConsumer apiConsumer;
  final String defaultCity;
  final String defaultCountry;
  final String defaultMethod;
  final String defaultTune;

  PrayerTimesRepoImpl({
    required this.apiConsumer,
    this.defaultCity = 'cairo',
    this.defaultCountry = 'eg',
    this.defaultMethod = '5',
    this.defaultTune = '0,-1,1,1,2,1,1,2,0',
  });

  @override
  Future<Either<Failure, PrayerTimesModel>> fetchPrayerTimes({
    required String city,
    required String country,
    DateTime? date,
  }) async {
    try {
      if (city.isEmpty || country.isEmpty) {
        return Left(ApiFailure('City and country cannot be empty'));
      }
      final targetDate = date ?? DateTime.now();
      final formattedDate = DateFormat('dd-MM-yyyy').format(targetDate);

      final response = await apiConsumer.get(
        '${EndpointConstants.prayerTimesEndpoint}/$formattedDate',
        queryParameters: {
          'city': city,
          'country': country,
          'tune': defaultTune,
          'method': defaultMethod,
        },
      );

      if (response == null) {
        return Left(ApiFailure('No data received from the server'));
      }

      return Right(PrayerTimesModel.fromJson(response));
    } on DioException catch (dioException) {
      return Left(ApiFailure.fromDioException(dioException));
    } on FormatException catch (e) {
      return Left(ApiFailure('Invalid data format: ${e.message}'));
    } catch (e) {
      return Left(ApiFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
