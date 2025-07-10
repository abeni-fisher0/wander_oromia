import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/data/models/stop_model.dart';
import 'package:frontend/data/services/stop_service.dart';
import '../../widgets/bottom_nav.dart';

class TrailPage extends StatefulWidget {
  final String trailId;
  final String title;

  const TrailPage({Key? key, required this.trailId, required this.title})
    : super(key: key);

  @override
  State<TrailPage> createState() => _TrailPageState();
}

class _TrailPageState extends State<TrailPage> {
  List<StopModel> stops = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStops();
  }

  Future<void> _loadStops() async {
    try {
      final result = await StopService.getStopsByTrailId(widget.trailId);
      setState(() => stops = result);
    } catch (e) {
      print('❌ Error loading stops: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.go(
            '/itinerary',
            extra: {'trailId': widget.trailId, 'title': widget.title},
          );
        },
        icon: const Icon(Icons.map),
        label: const Text('View Itinerary'),
        backgroundColor: Colors.green,
      ),
      appBar: AppBar(
        title: Text('${widget.title} Trail'),
        backgroundColor: Colors.green,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    stops.isEmpty
                        ? const Center(
                          child: Text('No stops found for this trail'),
                        )
                        : GridView.builder(
                          itemCount: stops.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 16,
                                childAspectRatio: 0.75,
                              ),
                          itemBuilder: (context, index) {
                            final stop = stops[index];
                            return GestureDetector(
                              onTap: () {
                                context.go(
                                  '/stop/${Uri.encodeComponent(stop.name)}',
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        stop.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Text(
                                        'Learn more',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
    );
  }
}
