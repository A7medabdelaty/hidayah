import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hidayah/core/models/location_data.dart';
import 'package:hidayah/core/services/location_service.dart';

class LocationPickerMap extends StatefulWidget {
  final Function(LocationData) onLocationPicked;
  static const routeName = '/location-picker-map';

  const LocationPickerMap({
    super.key,
    required this.onLocationPicked,
  });

  @override
  State<LocationPickerMap> createState() => _LocationPickerMapState();
}

class _LocationPickerMapState extends State<LocationPickerMap> {
  final LocationService _locationService = LocationService();
  GoogleMapController? _mapController;
  LocationData? _selectedLocation;

  Future<void> _getCurrentLocation() async {
    try {
      final location = await _locationService.getCurrentLocation();
      if (_mapController != null) {
        await _mapController!.animateCamera(
          CameraUpdate.newLatLngZoom(location.latLng, 15),
        );
        setState(() => _selectedLocation = location);
      }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }

  Future<void> _onLocationSelected(LatLng latLng) async {
    final location = await _locationService.getLocationData(latLng);
    setState(() => _selectedLocation = location);
    widget.onLocationPicked(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildMap(),
          _buildCurrentLocationButton(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_selectedLocation?.address ?? 'Select Location'),
      actions: [
        if (_selectedLocation != null)
          TextButton(
            onPressed: () {
              widget.onLocationPicked(_selectedLocation!);
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
      ],
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      onMapCreated: (controller) {
        _mapController = controller;
        _getCurrentLocation();
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(30.0444, 31.2357),
        zoom: 2,
      ),
      onTap: _onLocationSelected,
      markers: _selectedLocation != null
          ? {
              Marker(
                markerId: const MarkerId('selected'),
                position: _selectedLocation!.latLng,
              ),
            }
          : {},
    );
  }

  Widget _buildCurrentLocationButton() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: FloatingActionButton(
        onPressed: _getCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
