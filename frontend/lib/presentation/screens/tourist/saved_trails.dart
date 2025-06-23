import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/data/models/saved_trail_model.dart';
import 'package:frontend/data/services/trail_service.dart';
import '../../widgets/bottom_nav.dart';

class SavedTrailsPage extends StatefulWidget {
  const SavedTrailsPage({Key? key}) : super(key: key);

  @override
  State<SavedTrailsPage> createState() => _SavedTrailsPageState();
}

class _SavedTrailsPageState extends State<SavedTrailsPage> {
  List<SavedTrailModel> savedTrails = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedTrails();
  }

  Future<void> _loadSavedTrails() async {
    try {
      final trails = await TrailService.getSavedTrails();
      setState(() => savedTrails = trails);
    } catch (e) {
      print('Error loading saved trails: $e');
      // You can show a snackbar or fallback message here
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Trails'),
        backgroundColor: Colors.green,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Image(
              image: AssetImage('assets/images/flag.png'),
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : savedTrails.isEmpty
              ? const Center(child: Text('No saved trails yet.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: savedTrails.length,
                  itemBuilder: (context, index) {
                    final trail = savedTrails[index].trail;

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDFFFD9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () => context.push('/itinerary'), // optional: pass trail ID
                        child: Row(
                          children: [
                            // Placeholder or actual image
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: trail.imageUrl != null && trail.imageUrl.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        trail.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(Icons.image, color: Colors.white70),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trail.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  trail.category,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
