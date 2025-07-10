import 'package:flutter/material.dart';
import 'package:frontend/presentation/widgets/bottom_nav.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/data/models/trail_model.dart';
import 'package:frontend/data/services/trail_service.dart';
import 'package:frontend/presentation/widgets/guide_bottom_nav.dart';

class GuideHomePage extends StatefulWidget {
  const GuideHomePage({Key? key}) : super(key: key);

  @override
  State<GuideHomePage> createState() => _GuideHomePageState();
}

class _GuideHomePageState extends State<GuideHomePage> {
  final Map<String, String> displayToCategory = {
    'Festivals': 'Festivals',
    'Foods and Cuisines': 'Food & Cuisine',
    'Wildlife preservation': 'Wildlife',
  };

  final Map<String, List<TrailModel>> categoryTrails = {};
  final TextEditingController searchController = TextEditingController();
  List<TrailModel> searchResults = [];
  bool isSearching = false;
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

  Future<void> _searchTrails(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        isSearching = false;
        searchResults = [];
      });
      return;
    }

    setState(() => isLoading = true);
    try {
      final results = await TrailService.searchTrails(query);
      setState(() {
        isSearching = true;
        searchResults = results;
      });
    } catch (e) {
      print('Search error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void navigateToTrail(BuildContext context, TrailModel trail) {
    context.push('/guide-trail', extra: {
      'trailId': trail.id,
      'title': trail.title,
    });
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
                onPressed: () {},
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
              return buildTrailCard(trail);
            },
          ),
        ),
      ],
    );
  }

  Widget buildTrailCard(TrailModel trail) {
    return GestureDetector(
      onTap: () => navigateToTrail(context, trail),
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
  }

  @override
  Widget build(BuildContext context) {
    final displayNames = displayToCategory.keys.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: searchController,
                      onChanged: _searchTrails,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  searchController.clear();
                                  _searchTrails('');
                                },
                              )
                            : null,
                        hintText: 'Search trails...',
                        filled: true,
                        fillColor: const Color(0xFFDFFFD9),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  if (isSearching)
                    ...searchResults.map((trail) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: buildTrailCard(trail),
                        ))
                  else ...[
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Guide Trail List',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (final display in displayNames)
                      if (categoryTrails[display]?.isNotEmpty ?? false)
                        buildSection(display, categoryTrails[display]!),
                    const SizedBox(height: 20),
                  ],
                ],
              ),
      ),
    );
  }
}
