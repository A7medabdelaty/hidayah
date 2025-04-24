import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hidayah/core/errors/failures.dart';
import 'package:hidayah/core/models/location_data.dart';

class LocationService {
  const LocationService();

  Future<LocationData> getCurrentLocation() async {
    final position = await getCurrentPosition();
    return getLocationData(
      LatLng(position.latitude, position.longitude),
    );
  }

  Future<LocationData> getLocationData(LatLng location) async {
    final address = await _getFormattedAddress(location);
    return LocationData(latLng: location, address: address);
  }

  Future<Position> getCurrentPosition() async {
    final hasPermission = await checkPermissions();
    if (!hasPermission) {
      throw LocationFailure('Location permission denied');
    }
    return Geolocator.getCurrentPosition();
  }

  Future<bool> checkPermissions() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return await requestPermission();
    }
    return permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever;
  }

  Future<bool> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever;
  }

  Future<String> _getFormattedAddress(LatLng location) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      return _formatAddress(placemarks);
    } catch (e) {
      throw LocationFailure('Failed to get address: $e');
    }
  }

  String _formatAddress(List<Placemark> placemarks) {
    if (placemarks.isEmpty) return 'Unknown Location';

    final place = placemarks.first;
    final components = [
      place.locality,
      place.subAdministrativeArea,
      _cleanGovernorate(place.administrativeArea),
      place.country,
    ].where((component) => component?.isNotEmpty ?? false);

    return components.join(', ');
  }

  String? _cleanGovernorate(String? area) {
    return area?.replaceAll('Governorate', '').trim();
  }
}
