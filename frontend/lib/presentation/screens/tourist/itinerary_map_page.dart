import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:frontend/presentation/widgets/bottom_nav.dart';
import 'package:latlong2/latlong.dart';
import 'package:frontend/data/models/stop_model.dart';
import 'package:frontend/data/models/guide_model.dart';
import 'package:frontend/data/services/stop_service.dart';
import 'package:frontend/data/services/itinerary_service.dart';
import 'package:frontend/data/services/guide_service.dart';
import 'package:frontend/data/services/booking_service.dart';
import 'package:frontend/data/models/booking_model.dart';
import 'package:frontend/core/utils/token_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:go_router/go_router.dart';

class ItineraryMapPage extends StatefulWidget {
  final String trailId;
  final String trailTitle;

  const ItineraryMapPage({
    super.key,
    required this.trailId,
    required this.trailTitle,
  });

  @override
  State<ItineraryMapPage> createState() => _ItineraryMapPageState();
}

class _ItineraryMapPageState extends State<ItineraryMapPage> {
  List<StopModel> selectedStops = [];
  List<GuideModel> guides = [];
  GuideModel? selectedGuide;

  DateTime? startDate;
  int numDays = 5;
  List<String> interests = [];

  final List<String> availableInterests = [
    'Coffee',
    'Nature',
    'Culture',
    'Hiking',
    'Food',
  ];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _askUserPreferences();
    });
  }

  Future<void> _askUserPreferences() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate == null) return;
    setState(() => startDate = pickedDate);

    await showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: numDays.toString());
        return AlertDialog(
          title: const Text('Trip Duration'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Number of days'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final input = int.tryParse(controller.text);
                if (input != null && input > 0) {
                  setState(() => numDays = input);
                  Navigator.pop(context);
                }
              },
              child: const Text('Next'),
            ),
          ],
        );
      },
    );

    await showDialog(
      context: context,
      builder: (context) {
        final selected = <String>{};
        return StatefulBuilder(
          builder: (context, setLocalState) {
            return AlertDialog(
              title: const Text('Select Interests'),
              content: Wrap(
                spacing: 10,
                children: availableInterests.map((interest) {
                  final isSelected = selected.contains(interest);
                  return FilterChip(
                    label: Text(interest),
                    selected: isSelected,
                    onSelected: (val) {
                      setLocalState(() {
                        isSelected ? selected.remove(interest) : selected.add(interest);
                      });
                    },
                  );
                }).toList(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() => interests = selected.toList());
                    Navigator.pop(context);
                    _loadStops();
                  },
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _loadStops() async {
    try {
      final stops = await StopService.getAllStops();
      setState(() {
        selectedStops = stops
            .where((s) => s.trailId == widget.trailId)
            .take(numDays)
            .toList();
        isLoading = false;
      });

      final token = await TokenStorage.getToken();
      if (token != null) {
        final decoded = JwtDecoder.decode(token);
        final uid = decoded['uid'];

        await ItineraryService.createItinerary({
          'userId': uid,
          'trailId': widget.trailId,
          'startDate': startDate?.toIso8601String(),
          'preferences': interests,
          'stops': selectedStops.asMap().entries.map((e) {
            return {'stopId': e.value.id, 'day': e.key + 1};
          }).toList(),
        });
      }
    } catch (e) {
      print('❌ Failed to load stops: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _showGuideSelector() async {
    try {
      final fetched = await GuideService.getGuidesByTrail(widget.trailId);
      setState(() => guides = fetched);

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return SizedBox(
            height: 420,
            child: Column(
              children: [
                const SizedBox(height: 12),
                const Text("Select Your Guide", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: guides.length,
                    itemBuilder: (context, index) {
                      final guide = guides[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedGuide = guide);
                          Navigator.pop(context);
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: Container(
                            width: 240,
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (guide.photo != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(guide.photo!, height: 120, width: double.infinity, fit: BoxFit.cover),
                                  ),
                                const SizedBox(height: 8),
                                Text(guide.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                Text('Phone: ${guide.phone}'),
                                Text('Price: ${guide.price} birr'),
                                Text('Lang: ${guide.language}'),
                                Text('XP: ${guide.experience} years'),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      print("❌ Failed to fetch guides: $e");
    }
  }

  Future<void> _bookTrail() async {
  if (selectedGuide == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("⚠️ Please select a guide before booking."),
        backgroundColor: Colors.orange,
      ),
    );
    return;
  }

  try {
    final token = await TokenStorage.getToken();
    if (token != null) {
      final decoded = JwtDecoder.decode(token);
      final uid = decoded['uid'];

      await BookingService.createBooking(BookingModel(
        userId: uid,
        guideId: selectedGuide!.id,
        trailId: widget.trailId,
        date: startDate!,
      ));

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Booking confirmed!")),
        );
        context.go('/saved');
      }
    }
  } catch (e) {
    print("❌ Booking failed: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("❌ Failed to complete booking."),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final polyPoints = selectedStops
        .where((s) => s.lat != null && s.lng != null)
        .map((s) => LatLng(s.lat!, s.lng!))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.trailTitle} Itinerary'),
        backgroundColor: Colors.green,
        actions: [
          TextButton(
            onPressed: _showGuideSelector,
            child: const Text("Choose Guide", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _bookTrail,
        label: const Text("Book Trail"),
        icon: const Icon(Icons.check),
        backgroundColor: Colors.green,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...selectedStops.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stop = entry.value;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text('Day ${index + 1}: ${stop.name}'),
                      subtitle: Text(stop.description),
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  height: 300,
                  child: FlutterMap(
                    options: MapOptions(
                      center: polyPoints.isNotEmpty ? polyPoints[0] : LatLng(7.6736, 36.8350),
                      zoom: 6.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.yourcompany.wanderoromia',
                      ),
                      MarkerLayer(
                        markers: polyPoints.map((p) => Marker(
                          width: 40,
                          height: 40,
                          point: p,
                          child: const Icon(Icons.location_pin, color: Colors.red, size: 36),
                        )).toList(),
                      ),
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: polyPoints,
                            strokeWidth: 4.0,
                            color: Colors.blueAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
