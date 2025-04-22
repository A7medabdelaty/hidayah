class QiblaModel {
  final int code;
  final String status;
  final QiblaData data;

  QiblaModel({
    required this.code,
    required this.status,
    required this.data,
  });

  factory QiblaModel.fromJson(Map<String, dynamic> json) => QiblaModel(
        code: json['code'],
        status: json['status'],
        data: QiblaData.fromJson(json['data']),
      );
}

class QiblaData {
  final double latitude;
  final double longitude;
  final double direction;

  QiblaData({
    required this.latitude,
    required this.longitude,
    required this.direction,
  });

  factory QiblaData.fromJson(Map<String, dynamic> json) => QiblaData(
        latitude: json['latitude'],
        longitude: json['longitude'],
        direction: json['direction'],
      );
}
