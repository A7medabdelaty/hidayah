import 'package:dartz/dartz.dart';
import 'package:hidayah/core/errors/failures.dart';
import 'package:hidayah/features/prayer_time/data/models/cached_prayer_data.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';

abstract class PrayerTimesRepo {
  Future<Either<Failure, PrayerTimesModel>> fetchPrayerTimes({
    double? latitude,
    double? longitude,
    DateTime? date,
  });

  Future<Either<Failure, CachedPrayerData>> getCachedPrayerTimes();
}
