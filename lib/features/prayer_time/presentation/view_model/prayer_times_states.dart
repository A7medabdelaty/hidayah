import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';

abstract class PrayerTimesStates {}

class PrayerTimesInitial extends PrayerTimesStates {}

class PrayerTimesLoading extends PrayerTimesStates {}

class PrayerTimesSuccess extends PrayerTimesStates {
  final PrayerTimesModel prayerTimesModel;
  final String address;
  final bool isFromCache;

  PrayerTimesSuccess(
    this.prayerTimesModel,
    this.address, {
    this.isFromCache = false,
  });
}

class PrayerTimesOffline extends PrayerTimesStates {}

class PrayerTimesError extends PrayerTimesStates {
  final String errMessage;

  PrayerTimesError(this.errMessage);
}
