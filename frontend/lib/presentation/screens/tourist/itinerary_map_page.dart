import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:frontend/data/models/itinerary_model.dart';
import 'package:frontend/data/services/itinerary_service.dart';
import '../../widgets/bottom_nav.dart';

class ItineraryMapPage extends StatefulWidget {
  const ItineraryMapPage({super.key});

  @override
  State<ItineraryMapPage> createState() => _ItineraryMapPageState();
}

class _ItineraryMapPageState extends State<ItineraryMapPage> {
  List<ItineraryModel> itineraries = [];
  bool isLoading = true;

  List<Marker> _markers = [];
  LatLng _mapCenter = const LatLng(7.6736, 36.8350); // default fallback

  @override
  void initState() {
    super.initState();
    _loadItineraries();
  }

  Future<void> _loadItineraries() async {
    try {
      final result = await ItineraryService.getItineraries();
      setState(() {
        itineraries = result;
        _markers = _generateMarkers(result);

        if (_markers.isNotEmpty) {
          _mapCenter = _markers.first.point;
        }
      });
    } catch (e) {
      print('Failed to load itineraries: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  List<Marker> _generateMarkers(List<ItineraryModel> data) {
    final markers = <Marker>[];
    for (final itinerary in data) {
      for (final stop in itinerary.stops) {
        if (stop.stop.lat != null && stop.stop.lng != null) {
          markers.add(
            Marker(
              width: 40,
              height: 40,
              point: LatLng(stop.stop.lat!, stop.stop.lng!),
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 36,
              ),
            ),
          );
        }
      }
    }
    return markers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itinerary and Map'),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  SizedBox(
                    height: 300,
                    child: FlutterMap(
                      options: MapOptions(center: _mapCenter, zoom: 6.5),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(markers: _markers),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...itineraries.map(_buildItineraryCard),
                ],
              ),
    );
  }

  Widget _buildItineraryCard(ItineraryModel itinerary) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itinerary.trailId,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...itinerary.stops.map((stop) {
            final stopModel = stop.stop;
            final places = [stopModel.description];
            final img =
                stopModel.images.isNotEmpty
                    ? stopModel.images.first
                    : 'assets/images/default_stop.png';

            return _dayItem("Day ${stop.day}: ${stopModel.name}", places, img);
          }),
        ],
      ),
    );
  }

  Widget _dayItem(String title, List<String> places, String imgPath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child:
                imgPath.startsWith('http')
                    ? Image.network(
                      imgPath,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    )
                    : Image.asset(
                      imgPath,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                    ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                ...places.map(
                  (p) => Text('- $p', style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
