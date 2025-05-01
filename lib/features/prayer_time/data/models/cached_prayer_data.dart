import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hidayah/features/prayer_time/data/models/prayer_times_model.dart';

class CachedPrayerData {
  final PrayerTimesModel prayerTimes;
  final LatLng location;
  final String address;
  final DateTime timestamp;

  CachedPrayerData({
    required this.prayerTimes,
    required this.location,
    required this.address,
    required this.timestamp,
  });

  Map<String, dynamic> toJson() => {
        'prayerTimes': prayerTimes.toJson(),
        'location': {
          'latitude': location.latitude,
          'longitude': location.longitude,
        },
        'address': address,
        'timestamp': timestamp.toIso8601String(),
      };

  factory CachedPrayerData.fromJson(Map<String, dynamic> json) {
    return CachedPrayerData(
      prayerTimes: PrayerTimesModel.fromJson(json['prayerTimes']),
      location: LatLng(
        json['location']['latitude'],
        json['location']['longitude'],
      ),
      address: json['address'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}