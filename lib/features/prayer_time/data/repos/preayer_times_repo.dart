import 'package:dartz/dartz.dart';
import 'package:hidayah/core/errors/failures.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';

abstract class PrayerTimesRepo {
  Future<Either<Failure, PrayerTimesModel>> fetchPrayerTimes(
      {required String city, required String country});
}
