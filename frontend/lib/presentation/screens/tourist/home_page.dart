import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/data/models/trail_model.dart';
import 'package:frontend/data/services/trail_service.dart';
import 'package:frontend/presentation/widgets/bottom_nav.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, String> displayToCategory = {
    'Festivals': 'Festivals',
    'Foods and Cuisines': 'Food & Cuisine',
    'Wildlife preservation': 'Wildlife',
  };

  final Map<String, List<TrailModel>> categoryTrails = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTrails();
  }

  Future<void> _loadTrails() async {
    try {
      for (var entry in displayToCategory.entries) {
        final trails = await TrailService.getTrailsByCategory(entry.value);
        categoryTrails[entry.key] = trails;
      }
    } catch (e) {
      print('Error loading trails: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void navigateToTrailCategory(BuildContext context, String category) {
    final encoded = Uri.encodeComponent(category);
    context.push('/trail/$encoded');
  }

  Widget buildSection(String displayName, List<TrailModel> trails) {
    final limited = trails.take(5).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(displayName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () => navigateToTrailCategory(context, displayName),
                child: const Text("See all"),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: limited.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final trail = limited[index];
              return GestureDetector(
                onTap: () => navigateToTrailCategory(context, displayName),
                child: Container(
                  width: 130,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.network(
                          trail.imageUrl,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 100,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.image, size: 40),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          trail.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Explore', style: TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayNames = displayToCategory.keys.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Discover places',
                        filled: true,
                        fillColor: Color(0xFFDFFFD9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Welcome to Wander Oromia! 🇪🇹',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (final display in displayNames)
                    if (categoryTrails[display]?.isNotEmpty ?? false)
                      buildSection(display, categoryTrails[display]!),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
