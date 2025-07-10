import 'package:flutter/material.dart';
import 'package:frontend/data/models/trail_model.dart';
import 'package:frontend/data/services/guide_service.dart';
import 'package:frontend/core/utils/token_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../widgets/guide_bottom_nav.dart';

class GuideSavedTrailsPage extends StatefulWidget {
  const GuideSavedTrailsPage({super.key});

  @override
  State<GuideSavedTrailsPage> createState() => _GuideSavedTrailsPageState();
}

class _GuideSavedTrailsPageState extends State<GuideSavedTrailsPage> {
  List<TrailModel> savedTrails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedTrails();
  }

  Future<void> _loadSavedTrails() async {
    try {
      final token = await TokenStorage.getToken();
      if (token == null) {
        throw Exception('No token found');
      }

      final decoded = JwtDecoder.decode(token);
      final userId = decoded['uid'];

      final result = await GuideService.getSavedTrailsByGuide(userId);
      setState(() => savedTrails = result);
    } catch (e) {
      print('❌ Error loading saved trails: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Trails')),
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 2),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : savedTrails.isEmpty
              ? const Center(child: Text('No saved trails'))
              : ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: savedTrails.length,
                  itemBuilder: (context, index) {
                    final trail = savedTrails[index];
                    return Card(
                      child: ListTile(
                        leading: Image.network(
                          trail.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            width: 50,
                            height: 50,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        title: Text(trail.title),
                        subtitle: Text(trail.category),
                        onTap: () {
                          // Navigate to trail detail if needed
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
