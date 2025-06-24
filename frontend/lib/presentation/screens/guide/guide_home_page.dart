import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend/presentation/widgets/guide_bottom_nav.dart';

class GuideHomePage extends StatelessWidget {
  const GuideHomePage({super.key});

  final List<Map<String, dynamic>> trails = const [
    {
      "id": "trail001",
      "title": "Irreecha Festival Trail",
      "category": "Festivals",
      "imageUrl": "https://via.placeholder.com/150/irreecha",
    },
    {
      "id": "trail002",
      "title": "Coffee Heritage Trail",
      "category": "Food & Cuisine",
      "imageUrl": "https://via.placeholder.com/150/coffee",
    },
    {
      "id": "trail003",
      "title": "Bale Mountains Eco Trail",
      "category": "Nature & Eco",
      "imageUrl": "https://via.placeholder.com/150/bale",
    },
    {
      "id": "trail004",
      "title": "Wildlife Discovery Trail",
      "category": "Wildlife",
      "imageUrl": "https://via.placeholder.com/150/wildlife",
    },
    {
      "id": "trail005",
      "title": "Sof Omar Cave Trail",
      "category": "Nature & Eco",
      "imageUrl": "https://via.placeholder.com/150/sof_omar",
    },
    {
      "id": "trail006",
      "title": "Traditional Oromo Dishes Trail",
      "category": "Food & Cuisine",
      "imageUrl": "https://via.placeholder.com/150/food",
    },
    {
      "id": "trail007",
      "title": "Historical Cities Trail",
      "category": "Culture",
      "imageUrl": "https://via.placeholder.com/150/history",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: ListView(
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
              child: Row(
                children: [
                  Text(
                    'Welcome to Wander Oromia!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildCategorySection("Festivals", context),
            _buildCategorySection("Food & Cuisine", context),
            _buildCategorySection("Nature & Eco", context),
            _buildCategorySection("Wildlife", context),
            _buildCategorySection("Culture", context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(String category, BuildContext context) {
    final filtered = trails.where((t) => t["category"] == category).toList();
    if (filtered.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            category,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filtered.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemBuilder: (context, index) {
              final trail = filtered[index];
              return GestureDetector(
                onTap: () => context.push("/guidetrail/${trail["id"]}"),
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
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: Image.network(
                          trail["imageUrl"],
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (_, __, ___) => Container(
                                height: 100,
                                color: Colors.grey.shade300,
                                child: const Icon(Icons.image, size: 40),
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          trail["title"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Explore',
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
      ],
    );
  }
}
