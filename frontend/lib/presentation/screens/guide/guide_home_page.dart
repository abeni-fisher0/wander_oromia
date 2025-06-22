// lib/presentation/screens/guide/guide_home_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/guide_bottom_nav.dart';

class GuideHomePage extends StatelessWidget {
  const GuideHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Festivals',
        'image': 'assets/images/festival.jpg',
        'route': '/trail/festivals',
      },
      {
        'title': 'Food & Cuisine',
        'image': 'assets/images/coffee.jpg',
        'route': '/trail/food',
      },
      {
        'title': 'Nature & Eco',
        'image': 'assets/images/nature.jpg',
        'route': '/trail/nature',
      },
      {
        'title': 'Wildlife',
        'image': 'assets/images/wildlife.jpg',
        'route': '/trail/wildlife',
      },
      {
        'title': 'Keza',
        'image': 'assets/images/keza.jpg',
        'route': '/trail/keza',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome Tour Guide'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Image.asset('assets/images/flag.png', height: 24),
          ),
        ],
      ),
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 0),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Festivals',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildCategoryRow(context, categories.sublist(0, 1)),
          const SizedBox(height: 16),
          const Text(
            'Foods and Cuisines',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildCategoryRow(context, categories.sublist(1, 2)),
          const SizedBox(height: 16),
          const Text(
            'Wildlife Preservation',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildCategoryRow(context, categories.sublist(3, 4)),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(
    BuildContext context,
    List<Map<String, dynamic>> items,
  ) {
    return Row(
      children:
          items.map((category) {
            return Expanded(
              child: GestureDetector(
                onTap: () => context.go(category['route']),
                child: Container(
                  margin: const EdgeInsets.all(4),
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(category['image']),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black45,
                    ),
                    child: Text(
                      category['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
