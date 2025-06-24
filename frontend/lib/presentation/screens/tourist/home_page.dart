// tourist_home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrailData {
  final String id;
  final String title;
  final String imageUrl;
  final String category;

  TrailData(this.id, this.title, this.imageUrl, this.category);
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<TrailData> allTrails = [
    TrailData(
      "trail001",
      "Irreecha Festival",
      "assets/images/festival.jpg",
      "Festivals",
    ),
    TrailData(
      "trail002",
      "Coffee Heritage",
      "assets/images/coffee.jpg",
      "Foods and Cuisines",
    ),
    TrailData(
      "trail004",
      "Wildlife Discovery",
      "assets/images/wildlife.jpg",
      "Wildlife preservation",
    ),
    TrailData(
      "trail006",
      "Traditional Dishes",
      "assets/images/food.jpg",
      "Foods and Cuisines",
    ),
    TrailData(
      "trail007",
      "Historical Cities",
      "assets/images/history.jpg",
      "Festivals",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final categories = [
      "Festivals",
      "Foods and Cuisines",
      "Wildlife preservation",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Wander Oromia")),
      body: ListView(
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
          for (final category in categories)
            _buildCategorySection(context, category),
        ],
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String category) {
    final filtered = allTrails.where((t) => t.category == category).toList();

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
                onTap: () => context.push('/trail/${trail.id}'),
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
                        child: Image.asset(
                          trail.imageUrl,
                          height: 100,
                          fit: BoxFit.cover,
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
