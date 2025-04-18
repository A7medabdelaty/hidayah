class PrayerTimeCalculator {
  static (String name, String time, String remainingTime, double progress)
      getNextPrayer(Map<String, String> timings) {
    final now = DateTime.now();
    final prayers = [
      ('Isha', timings['Isha'] ?? '00:00'),
      ('Fajr', timings['Fajr'] ?? '00:00'),
      ('Sunrise', timings['Sunrise'] ?? '00:00'),
      ('Dhuhr', timings['Dhuhr'] ?? '00:00'),
      ('Asr', timings['Asr'] ?? '00:00'),
      ('Maghrib', timings['Maghrib'] ?? '00:00'),
    ];

    // Convert current prayer times to DateTime objects
    final prayerTimes = prayers.map((prayer) {
      final time = _convertToDateTime(prayer.$2);
      if (prayer.$1 == 'Fajr' || prayer.$1 == 'Sunrise') {
        // If current time is after Isha, these prayers are for next day
        final ishaTime = _convertToDateTime(prayers[0].$2);
        if (now.isAfter(ishaTime)) {
          return (prayer.$1, time.add(const Duration(days: 1)));
        }
      }
      return (prayer.$1, time);
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
          nextPrayer.$1,
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
      'Fajr',
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
