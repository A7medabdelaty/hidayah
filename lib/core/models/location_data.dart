import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData {
  final LatLng latLng;
  final String address;

  const LocationData({required this.latLng, required this.address});
}
