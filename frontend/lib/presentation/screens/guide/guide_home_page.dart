import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/guide_bottom_nav.dart';

class GuideHomePage extends StatelessWidget {
  const GuideHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'title': 'Ireecha Trail',
        'image': 'assets/images/irrecha.jpg',
        'route': '/trail/festivals',
      },
      {
        'title': 'Photgraphy Trail',
        'image': 'assets/images/land.jpg',
        'route': '/trail/festivals',
      },
      {
        'title': 'cuisineTrail',
        'image': 'assets/images/food.jpg',
        'route': '/trail/festivals',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const GuideBottomNavBar(currentIndex: 0),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            // 🔍 Search bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE9FFDD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Discover places',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🪧 Welcome text + logo
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Welcome to wander Oromia!',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'IrishGrover',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Image.asset(
                  'assets/images/logo.png',
                  height: 30,
                  width: 30,
                ),
              ],
            ),

            const SizedBox(height: 24),
            _buildCategorySection(context, 'Festivals', categories),
            const SizedBox(height: 24),
            _buildCategorySection(context, 'Foods and Cuisines', categories),
            const SizedBox(height: 24),
            _buildCategorySection(context, 'Wildlife preservation', categories),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'IrishGrover',
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 170,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return GestureDetector(
                onTap: () => context.go(item['route']),
                child: Container(
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4FFDD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          item['image'],
                          width: 140,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                fontFamily: 'IrishGrover',
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Explore',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
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
