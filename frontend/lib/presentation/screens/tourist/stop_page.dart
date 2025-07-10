import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/data/models/stop_model.dart';
import 'package:frontend/data/services/stop_service.dart';
import '../../widgets/bottom_nav.dart';

class StopPage extends StatefulWidget {
  final String stopName;
  const StopPage({super.key, required this.stopName});

  @override
  State<StopPage> createState() => _StopPageState();
}

class _StopPageState extends State<StopPage> {
  StopModel? stop;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStop();
  }

  Future<void> _loadStop() async {
    try {
      final result = await StopService.getStopByName(widget.stopName);
      setState(() {
        stop = result;
      });
    } catch (e) {
      print('❌ Failed to load stop: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.stopName),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home'); // or your default fallback page
            }
          },
        ),
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : stop == null
              ? const Center(child: Text('❌ Stop not found'))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          stop!.images.isNotEmpty
                              ? Image.network(
                                stop!.images.first,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )
                              : Container(
                                height: 200,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image, size: 80),
                              ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      stop!.description,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      '📍 Location',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (stop!.lat != null && stop!.lng != null)
                          ? 'Lat: ${stop!.lat}, Lng: ${stop!.lng}'
                          : 'Location not available',
                    ),
                  ],
                ),
              ),
    );
  }
}
