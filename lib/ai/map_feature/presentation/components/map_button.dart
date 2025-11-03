import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../map_screen.dart';

class MapButton extends StatelessWidget {
  final LatLng? initialLocation;
  final Function(LatLng)? onLocationSelected;
  final String label;
  final IconData icon;
  final EdgeInsetsGeometry? padding;

  const MapButton({
    Key? key,
    this.initialLocation,
    this.onLocationSelected,
    this.label = 'Select Location',
    this.icon = Icons.map,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        final location = await Navigator.of(context).push<LatLng>(
          MaterialPageRoute(
            builder: (context) => MapScreen(
              initialLocation: initialLocation,
              onLocationSelected: onLocationSelected,
            ),
          ),
        );
        
        if (location != null && onLocationSelected != null) {
          onLocationSelected!(location);
        }
      },
      icon: Icon(icon, size: 20),
      label: Text(
        label,
        style: const TextStyle(fontSize: 14),
      ),
      style: ElevatedButton.styleFrom(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
