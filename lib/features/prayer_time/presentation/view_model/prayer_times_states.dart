import 'package:hidayah/features/prayer_time/data/prayer_times_model.dart';

abstract class PrayerTimesStates {}

class PrayerTimesInitial extends PrayerTimesStates {}

class PrayerTimesLoading extends PrayerTimesStates {}

class PrayerTimesSucess extends PrayerTimesStates {
  final PrayerTimesModel prayerTimesModel;

  PrayerTimesSucess(this.prayerTimesModel);
}

class PrayerTimesError extends PrayerTimesStates {
  final String errmessage;

  PrayerTimesError(this.errmessage);
}
