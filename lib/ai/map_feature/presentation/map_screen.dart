import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import '../../../ai/styles.dart';

class MapScreen extends StatefulWidget {
  final LatLng? initialLocation;
  final Function(LatLng)? onLocationSelected;

  const MapScreen({
    Key? key,
    this.initialLocation,
    this.onLocationSelected,
  }) : super(key: key);

  static Route<LatLng?> route({LatLng? initialLocation}) {
    return MaterialPageRoute<LatLng?>(
      builder: (context) => MapScreen(initialLocation: initialLocation),
    );
  }

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late MapController _mapController;
  LatLng? _selectedLocation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _selectedLocation = widget.initialLocation;
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    if (_selectedLocation == null) {
      await _getCurrentLocation();
    } else {
      _mapController.move(_selectedLocation!, 15.0);
    }
    setState(() => _isLoading = false);
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location services are disabled.')),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permissions are permanently denied.'),
        ),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      if (!mounted) return;
      setState(() {
        _selectedLocation = LatLng(position.latitude, position.longitude);
        _mapController.move(_selectedLocation!, 15.0);
      });
    } catch (e) {
      debugPrint('Error getting location: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not get current location')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        backgroundColor: Colors.blue,
        actions: [
          if (widget.onLocationSelected != null)
            TextButton(
              onPressed: _selectedLocation != null
                  ? () {
                      Navigator.of(context).pop(_selectedLocation);
                    }
                  : null,
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: _selectedLocation ?? const LatLng(0, 0),
                    zoom: _selectedLocation != null ? 15.0 : 3.0,
                    onTap: (tapPosition, point) {
                      setState(() {
                        _selectedLocation = point;
                      });
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.example.app',
                    ),
                    if (_selectedLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 40.0,
                            height: 40.0,
                            point: _selectedLocation!,
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: FloatingActionButton(
                    onPressed: _getCurrentLocation,
                    child: const Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
    );
  }
}
