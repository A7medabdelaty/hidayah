import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationData {
  final LatLng latLng;
  final String address;

  LocationData({required this.latLng, required this.address});
}

class LocationService {
  Future<LocationData> getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    final latLng = LatLng(position.latitude, position.longitude);
    return getLocationData(latLng);
  }

  static Future<String> getFormattedAddress(LatLng location) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      if (placemarks.isNotEmpty) {
        return _formatPlacemarkToAddress(placemarks.first);
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
    }
    return 'Unknown Location';
  }

  static String _formatPlacemarkToAddress(Placemark place) {
    final addressComponents = [
      place.locality,
      place.subAdministrativeArea,
      _cleanGovernorate(place.administrativeArea),
      place.country,
    ];

    return addressComponents
        .where((component) => component != null && component.isNotEmpty)
        .join(', ');
  }

  static String? _cleanGovernorate(String? area) {
    return area?.replaceAll(RegExp(r'Governorate'), '').trim();
  }

  Future<LocationData> getLocationData(LatLng location) async {
    final address = await getFormattedAddress(location);
    return LocationData(latLng: location, address: address);
  }

  static Position createPosition(double latitude, double longitude) {
    return Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
      altitudeAccuracy: 0,
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      headingAccuracy: 0,
    );
  }
}
