class PrayerTimesModel {
  final int code;
  final String status;
  final PrayerTimesData data;

  PrayerTimesModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimesModel(
      code: json['code'],
      status: json['status'],
      data: PrayerTimesData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'status': status,
      'data': data.toJson(),
    };
  }
}

class PrayerTimesData {
  final Timings timings;
  final Date date;
  final Meta meta;

  PrayerTimesData({
    required this.timings,
    required this.date,
    required this.meta,
  });

  factory PrayerTimesData.fromJson(Map<String, dynamic> json) {
    return PrayerTimesData(
      timings: Timings.fromJson(json['timings']),
      date: Date.fromJson(json['date']),
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timings': timings.toJson(),
      'date': date.toJson(),
      'meta': meta.toJson(),
    };
  }
}

class Timings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstthird;
  final String lastthird;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
      firstthird: json['Firstthird'],
      lastthird: json['Lastthird'],
    );
  }

  Map<String, String> toJson() {
    return {
      'Fajr': fajr,
      'Sunrise': sunrise,
      'Dhuhr': dhuhr,
      'Asr': asr,
      'Sunset': sunset,
      'Maghrib': maghrib,
      'Isha': isha,
      'Imsak': imsak,
      'Midnight': midnight,
      'Firstthird': firstthird,
      'Lastthird': lastthird,
    };
  }
}

class Date {
  final String readable;
  final String timestamp;
  final Hijri hijri;
  final Gregorian gregorian;

  Date({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory Date.fromJson(Map<String, dynamic> json) {
    return Date(
      readable: json['readable'],
      timestamp: json['timestamp'],
      hijri: Hijri.fromJson(json['hijri']),
      gregorian: Gregorian.fromJson(json['gregorian']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'readable': readable,
      'timestamp': timestamp,
      'hijri': hijri.toJson(),
      'gregorian': gregorian.toJson(),
    };
  }
}

class Hijri {
  final String date;
  final String format;
  final String day;
  final WeekDay weekday;
  final Month month;
  final String year;
  final Designation designation;
  final List<String> holidays;
  final List<String> adjustedHolidays;
  final String method;

  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
    required this.adjustedHolidays,
    required this.method,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) {
    return Hijri(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: WeekDay.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
      holidays: List<String>.from(json['holidays']),
      adjustedHolidays: List<String>.from(json['adjustedHolidays']),
      method: json['method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'weekday': weekday.toJson(),
      'month': month.toJson(),
      'year': year,
      'designation': designation.toJson(),
      'holidays': holidays,
      'adjustedHolidays': adjustedHolidays,
      'method': method,
    };
  }
}

class Gregorian {
  final String date;
  final String format;
  final String day;
  final WeekDay weekday;
  final Month month;
  final String year;
  final Designation designation;
  final bool lunarSighting;

  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) {
    return Gregorian(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: WeekDay.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
      lunarSighting: json['lunarSighting'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'format': format,
      'day': day,
      'weekday': weekday.toJson(),
      'month': month.toJson(),
      'year': year,
      'designation': designation.toJson(),
      'lunarSighting': lunarSighting,
    };
  }
}

class WeekDay {
  final String en;
  final String? ar;

  WeekDay({
    required this.en,
    this.ar,
  });

  factory WeekDay.fromJson(Map<String, dynamic> json) {
    return WeekDay(
      en: json['en'],
      ar: json['ar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'en': en,
      'ar': ar,
    };
  }
}

class Month {
  final int number;
  final String en;
  final String? ar;
  final int? days;

  Month({
    required this.number,
    required this.en,
    this.ar,
    this.days,
  });

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
      number: json['number'],
      en: json['en'],
      ar: json['ar'],
      days: json['days'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'en': en,
      'ar': ar,
      'days': days,
    };
  }
}

class Designation {
  final String abbreviated;
  final String expanded;

  Designation({
    required this.abbreviated,
    required this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'abbreviated': abbreviated,
      'expanded': expanded,
    };
  }
}

class Meta {
  final double latitude;
  final double longitude;
  final String timezone;
  final Method method;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;

  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],
      method: Method.fromJson(json['method']),
      latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'],
      midnightMode: json['midnightMode'],
      school: json['school'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'method': method.toJson(),
      'latitudeAdjustmentMethod': latitudeAdjustmentMethod,
      'midnightMode': midnightMode,
      'school': school,
    };
  }
}

class Method {
  final int id;
  final String name;
  final Params params;
  final Location location;

  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      id: json['id'],
      name: json['name'],
      params: Params.fromJson(json['params']),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'params': params.toJson(),
      'location': location.toJson(),
    };
  }
}

class Params {
  final double fajr;
  final double isha;

  Params({
    required this.fajr,
    required this.isha,
  });

  factory Params.fromJson(Map<String, dynamic> json) {
    return Params(
      fajr: json['Fajr'],
      isha: json['Isha'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Fajr': fajr,
      'Isha': isha,
    };
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
