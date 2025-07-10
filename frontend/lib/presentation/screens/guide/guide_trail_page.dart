import 'package:flutter/material.dart';
import 'package:frontend/data/models/stop_model.dart';
import 'package:frontend/data/services/stop_service.dart';
import 'package:frontend/presentation/widgets/guide_bottom_nav.dart';
import 'package:go_router/go_router.dart';

class GuideTrailPage extends StatefulWidget {
  final String trailId;
  final String title;

  const GuideTrailPage({
    Key? key,
    required this.trailId,
    required this.title,
  }) : super(key: key);

  @override
  State<GuideTrailPage> createState() => _GuideTrailPageState();
}

class _GuideTrailPageState extends State<GuideTrailPage> {
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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 1),
      floatingActionButton: ElevatedButton(
        onPressed: () => context.push('/upload-guide', extra: {
          'trailId': widget.trailId,
        }),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text('Guide'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : stops.isEmpty
              ? const Center(child: Text('No stops found for this trail'))
              : ListView.builder(
                  itemCount: stops.length,
                  itemBuilder: (context, index) {
                    final stop = stops[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                            image: stop.images.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(stop.images.first),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),
                        title: Text(stop.name),
                        subtitle: Text(
                          stop.description.length > 50
                              ? '${stop.description.substring(0, 50)}...'
                              : stop.description,
                        ),
                        onTap: () => context.go('/stop/${Uri.encodeComponent(stop.name)}'),
                      ),
                    );
                  },
                ),
    );
  }
}
