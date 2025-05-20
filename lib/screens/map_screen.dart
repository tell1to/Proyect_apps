import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  LatLng? origin;
  LatLng? destination;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  final LatLng _initialPosition = const LatLng(-0.1807, -78.4678); // Quito

  Future<void> _goToPlace(String address) async {
    if (address.trim().isEmpty) return;

    final encodedAddress = Uri.encodeComponent(address);
    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=AIzaSyDQn8VaCpsVsWawYuNbolKz7mg_ZcF6O9E"
    );

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      print(data);

      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        final LatLng position = LatLng(location['lat'], location['lng']);

        setState(() {
          if (origin == null) {
            origin = position;
            _markers.add(Marker(markerId: const MarkerId('origin'), position: origin!));
          } else {
            destination = position;
            _markers.add(Marker(markerId: const MarkerId('destination'), position: destination!));
          }
        });

        final GoogleMapController mapController = await _controller.future;
        mapController.animateCamera(CameraUpdate.newLatLngZoom(position, 14));

        if (origin != null && destination != null) {
          await _drawRoute(origin!, destination!);
        }
      } else {
        _showSnackBar("Dirección no encontrada.");
      }
    } catch (e) {
      _showSnackBar("Error al buscar la ubicación.");
    }
  }

  Future<void> _drawRoute(LatLng start, LatLng end) async {
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=AIzaSyDQn8VaCpsVsWawYuNbolKz7mg_ZcF6O9E'
    );

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      print(data);

      if (data['status'] == 'OK') {
        final points = data['routes'][0]['overview_polyline']['points'];
        final List<LatLng> polylineCoordinates = _decodePolyline(points);

        setState(() {
          _polylines.add(Polyline(
            polylineId: const PolylineId('route'),
            points: polylineCoordinates,
            width: 5,
            color: const Color.fromARGB(255, 33, 243, 58),
          ));
        });
      } else {
        _showSnackBar("No se pudo trazar la ruta.");
      }
    } catch (e) {
      _showSnackBar("Error al trazar ruta.");
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Planificador de Ruta'),
        backgroundColor: const Color.fromARGB(255, 63, 181, 63),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 12),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
            polylines: _polylines,
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar dirección...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => _goToPlace(_searchController.text),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
