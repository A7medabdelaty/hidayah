import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hidayah/core/exceptions/location_exception.dart';
import 'package:hidayah/core/models/location_data.dart';
import 'package:hidayah/core/services/base_service.dart';

class LocationService extends BaseService {
  const LocationService();

  Position createPosition(double latitude, double longitude) {
    return Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
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

  Future<Position> getCurrentPosition() async {
    final hasPermission = await checkPermissions();
    if (!hasPermission) {
      throw LocationException('Location permission denied');
    }
    return Geolocator.getCurrentPosition();
  }

  Future<LocationData> getCurrentLocation() async {
    final position = await getCurrentPosition();
    return getLocationData(
      LatLng(position.latitude, position.longitude),
    );
  }

  Future<LocationData> getLocationData(LatLng location) async {
    final address = await getFormattedAddress(location);
    return LocationData(latLng: location, address: address);
  }

  static Future<String> getFormattedAddress(LatLng location) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        location.latitude,
        location.longitude,
      );
      return _formatAddress(placemarks);
    } catch (e) {
      throw LocationException('Failed to get address: $e');
    }
  }

  static String _formatAddress(List<Placemark> placemarks) {
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

  static String? _cleanGovernorate(String? area) {
    return area?.replaceAll('Governorate', '').trim();
  }
}
