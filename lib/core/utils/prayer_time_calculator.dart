class PrayerTimeCalculator {
  static const Map<String, String> _prayerNamesAr = {
    'Fajr': 'الفجر',
    'Sunrise': 'الشروق',
    'Dhuhr': 'الظهر',
    'Asr': 'العصر',
    'Maghrib': 'المغرب',
    'Isha': 'العشاء',
  };

  static (String name, String time, String remainingTime, double progress)
      getNextPrayer(Map<String, String> timings, {required String locale}) {
    final now = DateTime.now();
    // Order prayers in chronological sequence
    final prayers = [
      ('Fajr', timings['Fajr'] ?? '00:00', _prayerNamesAr['Fajr']!),
      ('Sunrise', timings['Sunrise'] ?? '00:00', _prayerNamesAr['Sunrise']!),
      ('Dhuhr', timings['Dhuhr'] ?? '00:00', _prayerNamesAr['Dhuhr']!),
      ('Asr', timings['Asr'] ?? '00:00', _prayerNamesAr['Asr']!),
      ('Maghrib', timings['Maghrib'] ?? '00:00', _prayerNamesAr['Maghrib']!),
      ('Isha', timings['Isha'] ?? '00:00', _prayerNamesAr['Isha']!),
    ];

    // Convert all prayer times to DateTime objects
    final prayerTimes = prayers.map((prayer) {
      final time = _convertToDateTime(prayer.$2);
      // If current time is after Isha and we're looking at next day's prayers
      if (now.isAfter(_convertToDateTime(prayers.last.$2))) {
        return (prayer.$1, time, prayer.$3);
      }
      return (prayer.$1, time, prayer.$3);
    }).toList();

    // Find next prayer
    for (var i = 0; i < prayerTimes.length; i++) {
      if (now.isBefore(prayerTimes[i].$2)) {
        final currentPrayer = i > 0 ? prayerTimes[i - 1] : prayerTimes.last;
        final nextPrayer = prayerTimes[i];

        final totalDuration =
            nextPrayer.$2.difference(currentPrayer.$2).inMinutes;
        final elapsedDuration = now.difference(currentPrayer.$2).inMinutes;
        final progress = 1.0 - (elapsedDuration / totalDuration);
        return (
          locale == 'ar' ? prayers[i].$3 : prayers[i].$1,
          prayers[i].$2,
          _formatDuration(nextPrayer.$2.difference(now)),
          progress.clamp(0.0, 1.0)
        );
      }
    }

    // If after Isha, return next day's Fajr
    final nextFajr =
        _convertToDateTime(prayers[1].$2).add(const Duration(days: 1));
    final lastIsha = _convertToDateTime(prayers[0].$2);

    final totalDuration = nextFajr.difference(lastIsha).inMinutes;
    final elapsedDuration = now.difference(lastIsha).inMinutes;
    final progress = 1.0 - (elapsedDuration / totalDuration);
    return (
      locale == 'ar' ? _prayerNamesAr['Fajr']! : 'Fajr',
      prayers[1].$2,
      _formatDuration(nextFajr.difference(now)),
      progress.clamp(0.0, 1.0)
    );
  }

  static DateTime _convertToDateTime(String time) {
    final parts = time.split(':');
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );
  }

  static String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    return '$hours:$minutes';
  }
}
